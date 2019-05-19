import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

class FazzDioInspector extends InterceptorsWrapper {
  IOWebSocketChannel ws;

  FazzDioInspector({@required this.ws}) : super();

  @override
  onRequest(RequestOptions options) {
    return super.onRequest(options);
  }

  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    return super.onError(err);
  }
}
