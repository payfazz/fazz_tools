import 'package:dio/dio.dart';
import 'package:fazz_tools/model/http_result.dart';
import 'package:fazz_tools/model/print_options.dart';
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
        options: PrintOptions(
          color: "red",
        ),
      ).stringify(),
    );
    _sendHTTPResult(err.response, isError: true);
    return super.onError(err);
  }

  void _sendHTTPResult(Response response, {isError = false}) {
    String baseUrl =
        response.request.baseUrl == null ? "" : response.request.baseUrl;
    String path = response.request.path == null ? "" : response.request.path;

    Map<String, List<String>> responseHeaders = {};
    response.headers.forEach((name, value) {
      responseHeaders[name] = value;
    });

    ws.sink.add(
      SendLog(
        text: HttpResult(
          url: '$baseUrl$path',
          method: response.request.method,
          body: response.request.data,
          params: response.request.queryParameters,
          requestHeaders: response.request.headers,
          responseBody: response.data,
          responseHeaders: responseHeaders,
          statusCode: response.statusCode,
          isError: isError,
        ).toJson(),
        type: LogType.network,
      ).stringify(),
    );
  }
}
