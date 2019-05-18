import 'package:fazz_tools/tools/log/log.dart';
import 'package:fazz_tools/tools/network_inspector/network_inspector.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

abstract class FazzToolsInterface {
  FazzLog get log;
  FazzNetworkInspector get networkInspector;
}

class FazzTools implements FazzToolsInterface {
  bool isDebug;
  int port;
  String hostname;
  IOWebSocketChannel _ws;
  FazzLogInterface _log;
  FazzNetworkInspectorInterface _networkInspector;

  FazzTools(
      {@required this.isDebug, @required this.hostname, @required this.port}) {
    if (isDebug) {
      _ws = IOWebSocketChannel.connect('ws//${hostname}:${port}');
      _log = FazzLog(ws: _ws);
      _networkInspector = FazzNetworkInspector(ws: _ws);

      return;
    }
  }

  FazzLog get log => _log;
  FazzNetworkInspector get networkInspector => _networkInspector;
}
