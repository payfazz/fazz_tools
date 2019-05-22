import 'dart:async';

import 'package:web_socket_channel/io.dart';
import 'package:mockito/mockito.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MockWebSocketSink extends Mock implements WebSocketSink {}

class MockIOWebSocketChannel extends Mock implements IOWebSocketChannel {
  @override
  WebSocketSink get sink => MockWebSocketSink();
}
