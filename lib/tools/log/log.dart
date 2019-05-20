import 'package:fazz_tools/model/print_group.dart';
import 'package:fazz_tools/model/print_options.dart';
import 'package:fazz_tools/model/send_log.dart';
import 'package:fazz_tools/model/timer_log.dart';
import 'package:fazz_tools/value/log_display.dart';
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
    if (_textQueu.length > 0) {
      int _lastIndex = _textQueu.length - 1;
      _textQueu[_lastIndex].addText(
        SendLog(
          text: text,
          options: options,
        ),
      );

      return;
    }

    ws.sink.add(SendLog(
      text: text,
      options: options,
    ).stringify());
  }

  @override
  void printTable(dynamic text, {PrintOptions options}) {
    ws.sink.add(
      SendLog(
        text: text,
        showAs: LogDisplay.table,
        options: options,
      ).stringify(),
    );
  }

  @override
  void printGroup(String labelName) {
    _textQueu.add(
      PrintGroup(
        labelName: labelName,
      ),
    );
  }

  @override
  void printEndGroup() {
    if (_textQueu.length > 0) {
      int _lastIndex = _textQueu.length - 1;
      PrintGroup _group = _textQueu[_lastIndex];

      ws.sink.add(SendLog(
        text: 'Start: ${_group.labelName}',
      ).stringify());

      _group.texts.forEach(
        (SendLog _log) => ws.sink.add(_log.stringify()),
      );

      ws.sink.add(SendLog(
        text: 'End: ${_group.labelName}',
      ).stringify());

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
          ).toJson(),
        ).stringify(),
      );
    }
  }
}
