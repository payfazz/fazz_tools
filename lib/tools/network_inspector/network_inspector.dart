import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

abstract class FazzNetworkInspectorInterface {}

class FazzNetworkInspector implements FazzNetworkInspectorInterface {
  IOWebSocketChannel ws;

  FazzNetworkInspector({@required this.ws});
}
