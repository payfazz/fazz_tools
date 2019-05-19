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
  int port;
  String hostname;
  IOWebSocketChannel _ws;
  FazzLogInterface _log;
  FazzDioInspector _dio;
  FazzNetworkInspectorInterface _networkInspector;

  FazzTools({
    @required this.isDebug,
    @required this.hostname,
    @required this.port,
  }) {
    if (isDebug) {
      _ws = IOWebSocketChannel.connect('ws//$hostname:$port');
      _log = FazzLog(ws: _ws);
      _dio = FazzDioInspector(ws: _ws);
      _networkInspector = FazzNetworkInspector(dio: _dio);

      return;
    }
  }

  FazzLogInterface get log => _log;
  FazzNetworkInspectorInterface get networkInspector => _networkInspector;
}
