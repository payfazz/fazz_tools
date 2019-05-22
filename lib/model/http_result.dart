import 'dart:convert';

import 'package:fazz_tools/model/stringify.dart';
import 'package:flutter/foundation.dart';

class HttpResult implements Stringify {
  String url;
  Map<String, dynamic> requestHeaders;
  Map<String, dynamic> responseHeaders;
  String method;
  Map<String, dynamic> params;
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
    @required this.body,
    @required this.responseBody,
    @required this.statusCode,
    isError = false,
  }) : this.isError = isError;

  @override
  String stringify() => jsonEncode(toJson());

  @override
  Map<String, dynamic> toJson() => {
        "url": url,
        "requestHeaders": requestHeaders,
        "responseHeaders": responseHeaders,
        "method": method,
        "params": params,
        "body": body,
        "responseBody": responseBody,
        "statusCode": statusCode,
        "isError": isError,
      };
}
