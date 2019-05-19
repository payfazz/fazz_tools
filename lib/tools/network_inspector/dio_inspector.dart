import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fazz_tools/model/http_result.dart';
import 'package:fazz_tools/model/send_log.dart';
import 'package:fazz_tools/value/log_type.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/io.dart';

class FazzDioInspector extends InterceptorsWrapper {
  IOWebSocketChannel ws;

  FazzDioInspector({@required this.ws}) : super();
  @override
  onResponse(Response response) {
    _sendHTTPResult(response);
    return super.onResponse(response);
  }

  @override
  onError(DioError err) {
    ws.sink.add(
      SendLog(
        text: err.message,
      ).stringify(),
    );
    _sendHTTPResult(err.response, isError: true);
    return super.onError(err);
  }

  void _sendHTTPResult(Response response, {isError = false}) {
    ws.sink.add(
      SendLog(
        text: HttpResult(
          url: response.realUri.toString(),
          method: response.request.method,
          contentType: response.request.contentType.toString(),
          body: response.request.data,
          params: response.request.queryParameters,
          requestHeaders: response.request.headers,
          responseBody: response.data,
          responseHeaders:
              jsonDecode(jsonEncode(response.headers)) as Map<String, dynamic>,
          statusCode: response.statusCode,
          isError: isError,
        ).stringify(),
        type: LogType.network,
      ).stringify(),
    );
  }
}
