import 'package:fazz_tools/model/print_group.dart';
import 'package:fazz_tools/model/print_options.dart';
import 'package:fazz_tools/model/send_log.dart';
import 'package:fazz_tools/model/timer_log.dart';
import 'package:fazz_tools/value/log_type.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

abstract class FazzLogInterface {
  void print(dynamic text, {PrintOptions options});
  void printTable(dynamic text, {PrintOptions options});
  void printGroup(String labelName);
  void printEndGroup();
  void timerStart();
  void timerEnd();
}

class FazzLog implements FazzLogInterface {
  IOWebSocketChannel ws;
  List<int> _timerQueu;
  List<PrintGroup> _textQueu;

  FazzLog({@required this.ws})
      : _timerQueu = [],
        _textQueu = [];

  @override
  void print(dynamic text, {PrintOptions options}) {
    SendLog _log = SendLog(
      text: text,
      options: options,
    );

    if (_textQueu.length > 0) {
      int _lastIndex = _textQueu.length - 1;
      _textQueu[_lastIndex].addText(_log);

      return;
    }

    ws.sink.add(_log);
  }

  @override
  void printTable(dynamic text, {PrintOptions options}) {
    ws.sink.add(SendLog(
      text: text,
      type: LogType.table,
      options: options,
    ));
  }

  @override
  void printGroup(String labelName) {
    _textQueu.add(PrintGroup(labelName: labelName));
  }

  @override
  void printEndGroup() {
    if (_textQueu.length > 0) {
      int _lastIndex = _textQueu.length - 1;
      PrintGroup _group = _textQueu[_lastIndex];

      ws.sink.add(SendLog(text: _group.labelName));

      _group.texts.forEach((SendLog _log) => ws.sink.add(_log));
      _textQueu.removeAt(_lastIndex);
    }
  }

  @override
  @override
  void timerStart() {
    int _currTime = DateTime.now().millisecondsSinceEpoch;
    _timerQueu.add(_currTime);
  }

  @override
  void timerEnd() {
    if (_timerQueu.length > 0) {
      int _oldTime = _timerQueu.removeAt(0);
      int _currTime = DateTime.now().millisecondsSinceEpoch;
      int _range = _currTime - _oldTime;

      ws.sink.add(
        SendLog(
          text: TimerLog(
            startTime: _oldTime,
            endTime: _currTime,
            range: _range,
          ),
        ),
      );
    }
  }
}
