import 'dart:io';
import 'responder.dart';

class Request {
  Request({this.request, this.handler});

  final HttpRequest request;
  final Handler handler;

  String id() => ""; // TODO: FIGURE THIS OUT
  params() => {}; // TODO:
  HttpHeaders headers() => request.headers;
  String hostname() => request.uri.host;
  String method() => handler.method;
  Uri uri() => request.uri;
  body() => {}; // TODO: FIGURE THIS OUT

}

class Response {
  Response(this.httprequest);

  final HttpRequest httprequest;

  void code(int code) {
    httprequest.response.statusCode = code;
  }

  void header(String name, String, value) {
    httprequest.response.headers.add(name, value);
  }

  void headers(Map<String, String> headers) {
    headers.forEach((key, value) {
      httprequest.response.headers.add(key, value);
    });
  }

  HttpHeaders getHeaders() => httprequest.response.headers;

  void type(ContentType type) =>
      httprequest.response.headers.contentType = type;

  bool hasHeader(headerName) {
    var isHeader = false;
    httprequest.response.headers.forEach((name, values) {
      if (headerName == name) isHeader = true;
    });

    return isHeader;
  }

  void removeHeader(String name) =>
      httprequest.response.headers.removeAll(name);
}
