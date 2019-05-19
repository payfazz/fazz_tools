import 'package:flutter/foundation.dart';

class HttpResult {
  String url;
  Map<String, dynamic> requestHeaders;
  Map<String, dynamic> responseHeaders;
  String method;
  Map<String, dynamic> params;
  String contentType;
  dynamic body;
  dynamic responseBody;
  int statusCode;
  bool isError;

  HttpResult({
    @required this.url,
    @required this.requestHeaders,
    @required this.responseHeaders,
    @required this.method,
    @required this.params,
    @required this.contentType,
    @required this.body,
    @required this.responseBody,
    @required this.statusCode,
    isError = false,
  });
}
