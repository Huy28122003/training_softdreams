import 'dart:developer' as devtools show log;

import 'package:logging/logging.dart';

typedef LogHandlerFunction = void Function(LogRecord record);

final _levelEmojiMapper = {
  Level.INFO: 'ℹ️',
  Level.WARNING: '⚠️',
  Level.SEVERE: '⛔'
};

class Logging {
  Logging._();

  static Logger createLogger(
    String name, {
    Level logLevel = Level.INFO,
    LogHandlerFunction? logHandlerFunction,
  }) {
    final logger = Logger.detached(name)
      ..level = logLevel
      ..onRecord.listen(logHandlerFunction ?? _defaultLogHandler);
    return logger;
  }

  static LogHandlerFunction get _defaultLogHandler => (LogRecord record) {
        devtools.log(
          '${record.time} '
          '${_levelEmojiMapper[record.level] ?? record.level.name} '
          '${record.loggerName} ${record.message}',
        );
      };
}

final appLogger = Logging.createLogger('AppLogger');
