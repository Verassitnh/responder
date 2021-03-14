import 'dart:io';
import 'route.dart';

class Method {
  static final get = "GET";
  static final post = "POST";
  static final put = "PUT";
  static final options = "OPTIONS";
  static final delete = "DELETE";
  static final head = "HEAD";
  static final patch = "PATCH";
}

class Handler {
  Route endpoint;
  String method;
  Function body;
}

class Responder {
  Responder(this.settings);

  List<Handler> database = [];
  final Map<String, dynamic> settings;

  get(String route, cb) {
    var handler = Handler();
    handler.endpoint = Route(route);
    handler.method = Method.get;
    handler.body = cb;
    database.add(handler);
  }

  listen(int port, Function(int port, HttpServer server) callback) async {
    HttpServer server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    callback(port, server);
    await for (var request in server) {
      _handleEndpoints(request);
    }
  }

  _handleEndpoints(HttpRequest req) {
    database.forEach((handler) {
      if (handler.endpoint.match(req.uri.path) &&
          handler.method == req.method) {
        handler.body(req);
        req.response.close();
      }
    });
  }
}
