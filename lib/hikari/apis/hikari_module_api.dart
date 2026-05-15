import 'dart:async';
import 'dart:convert';

import 'package:amsl_app/hikari/exception.dart';
import 'package:amsl_app/hikari/hikari_api.dart';
import 'package:amsl_app/models/hikari/chat/websocket/websocket_request.dart';
import 'package:amsl_app/models/hikari/chat/websocket/websocket_response.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../models/hikari/chat/post.dart';
import '../../models/hikari/history/history_model.dart';
import '../../models/hikari/modules/module.dart';
import '../../models/hikari/modules/module_group.dart';

NumberFormat TIME_FORMAT = NumberFormat("00");

List<String> exclusiveModules = ["journaling-templates"];

bool isExclusive(String moduleId) => exclusiveModules.contains(moduleId);

String formatDate(DateTime date) {
  final String sign;
  final offsetMinutes = date.timeZoneOffset.inMinutes.abs();
  if (date.timeZoneOffset.isNegative && offsetMinutes != 0) {
    sign = "-";
  } else {
    sign = "+";
  }
  return "${date.toIso8601String()}$sign${TIME_FORMAT.format(offsetMinutes ~/ 60)}:${TIME_FORMAT.format(offsetMinutes % 60)}";
}

dynamic generateMetadata() {
  final now = DateTime.now();

  return {"time": formatDate(now)};
}

class HikariModuleApi {
  final BaseHikariApiClient hikari;
  static final log = Logger('hikariModuleApi');

  const HikariModuleApi(this.hikari);

  Future<List<Module>> getModules() async => hikari.get(
    "/modules",
    queryParameters: {"deep": "true"},
    transform: (json) {
      List<Module> modules = [];
      for (Map<String, dynamic> element in json['modules']) {
        modules.add(Module.fromJson(element));
      }
      return modules;
    },
  );

  Future<List<ModuleGroup>> getModuleGroups() async => hikari.get(
    "/modules/groups",
    transform: (json) {
      log.info("ModuleGroups: $json");
      List<ModuleGroup> groups = [];
      for (Map<String, dynamic> element in json) {
        groups.add(ModuleGroup.fromJson(element));
      }
      return groups;
    },
  );

  Future<Module> getSingleModule(String moduleId) async => hikari.get(
    "/modules/$moduleId",
    queryParameters: {"deep": "true"},
    transform: (json) => Module.fromJson(json),
  );

  Future<List<HistoryModel>> getHistory() async => hikari.get(
    "/modules/history",
    transform: (json) {
      List<HistoryModel> history = [];
      for (Map<String, dynamic> element in json) {
        history.add(HistoryModel.fromJson(element));
      }
      return history;
    },
  );

  Future<Post> startModuleSession({
    required String moduleId,
    required String sessionId,
  }) async {
    final body = {
      "metadata": generateMetadata(),
      "exclusive": isExclusive(moduleId),
    };

    return await hikari.post(
      "/modules/$moduleId/sessions/$sessionId/start",
      body: jsonEncode(body),
      transform: (json) {
        final post = Post.fromJson(json);
        return post;
      },
    );
  }

  Future<Post> resetModuleSession({
    required String moduleId,
    required String sessionId,
  }) async {
    final body = {
      "metadata": generateMetadata(),
      // "exclusive": isExclusive(moduleId)
    };
    return await hikari.post(
      "/modules/$moduleId/sessions/$sessionId/reset",
      body: jsonEncode(body),
      transform: (json) => Post.fromJson(json),
    );
  }

  Future abortModuleSession({
    required String moduleId,
    required String sessionId,
  }) async {
    final body = {"metadata": generateMetadata()};
    return await hikari.post(
      "/modules/$moduleId/sessions/$sessionId/abort",
      body: jsonEncode(body),
    );
  }

  Future abortModule({required String moduleId}) async {
    final body = {"metadata": generateMetadata()};
    return await hikari.post(
      "/modules/$moduleId/sessions/abort",
      body: jsonEncode(body),
    );
  }

  Future<Post> sendMessageToSession({
    required String moduleId,
    required String sessionId,
    required dynamic data,
    required String contentType,
    required String payloadKey,
    String? journalType,
    String? displayType,
  }) async {
    final body = {
      "payload": {
        "content_type": contentType,
        "content": {
          payloadKey: data,
          "type": ?journalType,
          "display-type": ?displayType,
        },
      },
      "metadata": generateMetadata(),
    };

    log.fine("JsonBody: ${jsonEncode(body)}");

    Post post = await hikari.post(
      "/modules/$moduleId/sessions/$sessionId/chat_v2",
      body: jsonEncode(body),
      transform: (json) => Post.fromJson(json),
    );

    return post;
  }

  Future<WebSocketChannel> connectToChat(
    String moduleId,
    String sessionId,
  ) async {
    WebSocketChannel channel = await hikari.connectToWs(
      "/modules/$moduleId/sessions/$sessionId/chat/ws",
    );
    await channel.ready;
    return channel;
  }

  Stream<WebsocketResponse> streamChat(WebSocketChannel channel) {
    final controller = StreamController<WebsocketResponse>();
    channel.stream.listen(
      (event) {
        final json = jsonDecode(event);
        log.info("Received message: $json");
        final response = WebsocketResponse.fromJson(json);
        switch (response) {
          case WebsocketResponse(type: "error", :final value as WebsocketError):
            controller.sink.addError(
              HikariServerException(value.error, value.statusCode),
            );
        }
        controller.sink.add(response);
      },
      onDone: () {
        log.info("Server closed websocket, ${channel.closeCode}");
        // We add this error to the stream so that the UI can react to it and knows that the websocket was closed
        controller.sink.addError(
          HikariClosedWebsocketException("Websocket closed", 1006),
        );
      },
    );
    return controller.stream;
  }

  void sendToChat(WebSocketChannel channel, WebsocketRequest request) {
    final body = request.toJson();
    log.info("Sending message: $body");
    channel.sink.add(json.encode(body));
  }

  Future<void> finishSession({
    required String session,
    required String module,
  }) async => hikari.post("/modules/$module/sessions/$session/finish");

  Future<Uint8List> getFile(String fileId) async =>
      hikari.get<Uint8List>("/modules/sources/$fileId", rawResponse: true);
}
