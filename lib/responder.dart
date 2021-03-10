import 'dart:io';

class Handler {
  String endpoint;
  String method;
  Function body;
}

class Responder {
  Responder(this.settings);

  List<Handler> database;
  final Map<String, dynamic> settings;

  get(String route, cb) {
    var handler = Handler();
    handler.endpoint = route;
    handler.method = "GET";
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
      if (dynamicRouteMatcher(handler.endpoint, req.requestedUri.path) &&
          handler.method == req.method) {
        handler.body();
        req.response.close();
      }
    });
  }
}
