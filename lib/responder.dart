import 'dart:io';

class Responder {
  Responder([this._options]);

  final Map<String, dynamic> _options;
  
  get(String route, cb) {
    
  }

  post(String route, cb) {

  }

  put(String route, cb) {

  }

  delete(String route, cb) {
    
  }

  head(String route, cb) {

  }

  options(String route, cb) {

  }

  patch(String route, cb) {

  }

  listen(int port, Function(int port, HttpServer server) callback) async {
    HttpServer server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    callback(port, server);
    await for (var request in server) {
      // _handleEndpoints(request);
    }
  }

}