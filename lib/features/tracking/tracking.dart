import 'package:amsl_app/hikari/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as logger;
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../flavors.dart';

final sentryLog = logger.Logger("Sentry");
final matomoLog = logger.Logger("Motomo");

const ignoredSentryExceptions = [HikariUnauthorizedException];

class TrackingConstants {
  static String analyticsLabel =
      "Ich erlaube das Sammeln von Nutzungsdaten um die App zu verbessern";

  static String crashReportingLabel =
      "Ich erlaube das Sammeln von Fehlermeldungen um die App zu verbessern";
}

Future updateTrackers(
  bool analyticsPermission,
  bool crashReportingPermission, {
  String? userID,
}) async {
  await Future.wait([
    initMatomo(userID, analyticsPermission),
    initSentry(crashReportingPermission),
  ]);
}

Future initSentry(bool permission) async {
  final track = !kDebugMode && permission;
  if (Sentry.isEnabled) {
    sentryLog.info("Closing Sentry");
    await Sentry.close();
  }
  sentryLog.info("Initializing Sentry with tracking: $track");

  await SentryFlutter.init((options) {
    options.dsn = F.sentryUrl;
    options.tracesSampleRate = track ? 1.0 : null;
    options.debug = true;
    options.beforeSend = (event, hint) {
      if (ignoredSentryExceptions.contains(event.throwable.runtimeType)) {
        return null;
      }
      return event;
    };
  });
}

Future initMatomo(String? userId, bool allowTracking) async {
  if (MatomoTracker.instance.initialized) {
    matomoLog.info("Setting opt out to ${!allowTracking}");
    await MatomoTracker.instance.setOptOut(optOut: !allowTracking);
  } else if (allowTracking) {
    matomoLog.info("Initializing Matomo");
    await MatomoTracker.instance.initialize(
      siteId: F.siteId,
      url: F.matomoUrl,
      verbosityLevel: kDebugMode ? Level.all : Level.off,
    );
  }
  if (userId != null && MatomoTracker.instance.initialized) {
    matomoLog.info("Setting visitor id to $userId}");
    setMatomoVisitor(userId);
  }
}

void setMatomoVisitor(String userID) {
  matomoLog.info("Setting Matomo visitor to $userID");
  MatomoTracker.instance.setVisitorUserId(userID);
}

List<MapEntry<String, String>> _prepareDimensionEntry(
  TrackingDimension dimension,
  String value,
) {
  // Truncating to 255 characters because Matomo does not support more
  final List<MapEntry<String, String>> output = [];
  int limit = value.length;
  if (limit > 255) {
    output.add(
      MapEntry("dimension${TrackingDimension.truncated.id}", true.toString()),
    );
    limit = 255;
  }
  output.add(MapEntry("dimension${dimension.id}", value.substring(0, limit)));
  return output;
}

Map<String, String>? _checkedPrepareDimensionEntries(
  Map<TrackingDimension, String>? dimensions,
) {
  if (dimensions == null) {
    return null;
  }
  return _prepareDimensionEntries(dimensions);
}

Map<String, String> _prepareDimensionEntries(
  Map<TrackingDimension, String> dimensions,
) {
  return Map.fromEntries(
    dimensions.entries.expand(
      (entry) => _prepareDimensionEntry(entry.key, entry.value),
    ),
  );
}

void trackEvent({
  required TrackingCategory category,
  required TrackingAction action,
  String? name,
  num? value,
  Map<TrackingDimension, String>? dimensions,
}) {
  matomoLog.info(
    "Tracking event. Category: ${category.name}, Action: ${action.name}, Name: $name",
  );

  if (MatomoTracker.instance.initialized) {
    MatomoTracker.instance.trackEvent(
      eventInfo: EventInfo(
        category: category.name,
        action: action.name,
        name: name,
        value: value,
      ),
      dimensions: _checkedPrepareDimensionEntries(dimensions),
    );
  }
}

void trackDimensions({required Map<TrackingDimension, String> dimensions}) {
  matomoLog.info("Tracking dimensions: $dimensions");

  if (MatomoTracker.instance.initialized) {
    MatomoTracker.instance.trackDimensions(
      dimensions: _prepareDimensionEntries(dimensions),
    );
  }
}

void trackDimension({
  required TrackingDimension dimension,
  required String value,
}) {
  trackDimensions(dimensions: {dimension: value});
}

Future<void> sendFeedback(
  String screen,
  String feedback,
  Uint8List screenshot,
) async {
  final id = await Sentry.captureMessage(
    "Feedback in $screen",
    withScope: (scope) {
      scope.addAttachment(
        SentryAttachment.fromUint8List(
          screenshot,
          'screenshot.png',
          contentType: 'image/png',
        ),
      );
    },
  );
  await Sentry.captureFeedback(
    SentryFeedback(associatedEventId: id, message: feedback),
  );
}

enum TrackingCategory {
  module,
  session,
  journal,
  notification,
  journalMessage,
  journalAssist,
  journalInChatHistory,
  journalFocus,
  assessmentEvaluation,
  onboarding,
  profile,
  journalMood,
}

enum TrackingDimension {
  version(1), // Visit dimension
  variant(2), // Visit dimension
  text(3), // Action dimension
  truncated(4); // Action dimension - indicates that the text was truncated

  const TrackingDimension(this.id);

  final int id;
}

enum TrackingAction {
  open,
  close,
  start,
  finish,
  choose,
  update,
  activate,
  deactivate,
  export,
  add,
  edit,
  submit,
  show,
  hide,
  select,
  deselect,
}
