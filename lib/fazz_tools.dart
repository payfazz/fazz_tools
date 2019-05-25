import 'package:dio/dio.dart';
import 'package:fazz_tools/mocks/io_websocket_channel.dart';
import 'package:fazz_tools/core/log/log.dart';
import 'package:fazz_tools/core/dio_inspector/dio_inspector.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

abstract class FazzToolsInterface {
  FazzLogInterface get log;
  InterceptorsWrapper get dioInspector;
}

class FazzTools implements FazzToolsInterface {
  bool isDebug;
  String host;
  IOWebSocketChannel _ws;
  FazzLogInterface _log;
  FazzDioInspector _dioInspector;

  FazzTools({
    this.isDebug = true,
    @required this.host,
  }) {
    if (isDebug) {
      _ws = IOWebSocketChannel.connect('ws://$host:7071');
    } else {
      _ws = MockIOWebSocketChannel();
    }

    _log = FazzLog(ws: _ws);
    _dioInspector = FazzDioInspector(ws: _ws);
  }

  @override
  FazzLogInterface get log => _log;

  @override
  InterceptorsWrapper get dioInspector => _dioInspector;
}
