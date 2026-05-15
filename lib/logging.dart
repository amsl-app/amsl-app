import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// I used symbols since ANSI escape codes are not working (in my console)
String _getSymbol(LogRecord record) {
  if (record.level == Level.SEVERE || record.error != null) {
    return "🛑";
  } else if (record.level == Level.WARNING) {
    return "🟡";
  } else if (record.level == Level.INFO) {
    return "🟢";
  } else {
    return "🔍";
  }
}

void setupLogging() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      final symbol = _getSymbol(record);
      // ignore: avoid_print
      print(
        '$symbol: ${record.loggerName} (${record.level.name}): ${record.time}: ${record.message}',
      );
      if (record.error != null) {
        // ignore: avoid_print
        print('$symbol:  >>> ERROR: ${record.error}');
      }
      if (record.stackTrace != null) {
        // ignore: avoid_print
        print('$symbol:  >>> TRACE: ${record.stackTrace}');
      }
    });
  }
}

final class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    if (kDebugMode) {
      debugPrint('''
  {
    "provider": "${context.provider.name ?? context.provider.runtimeType}",
    ${newValue is AsyncError ? ' "error": "${newValue.error}" , "stackTrace": "${newValue.stackTrace}",' : ''}
    "newValue": "$newValue"
  }
  ''');
    }
  }
}
