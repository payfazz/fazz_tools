import 'package:fazz_tools/mocks/io_websocket_channel.dart';
import 'package:fazz_tools/tools/log/log.dart';
import 'package:fazz_tools/tools/network_inspector/dio_inspector.dart';
import 'package:fazz_tools/tools/network_inspector/network_inspector.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

abstract class FazzToolsInterface {
  FazzLogInterface get log;
  FazzNetworkInspectorInterface get networkInspector;
}

class FazzTools implements FazzToolsInterface {
  bool isDebug;
  String host;
  IOWebSocketChannel _ws;
  FazzLogInterface _log;
  FazzDioInspector _dio;
  FazzNetworkInspectorInterface _networkInspector;

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
    _dio = FazzDioInspector(ws: _ws);
    _networkInspector = FazzNetworkInspector(dio: _dio);
  }

  FazzLogInterface get log => _log;
  FazzNetworkInspectorInterface get networkInspector => _networkInspector;
}
