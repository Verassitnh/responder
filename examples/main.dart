import 'package:responder/responder.dart';

var app = Responder({});
var port = 3000;

void main() {
  app.get('/a{dynamic}/route', (req, res) {
    res.headers({
      "Content-type": "application/json",
      "x-foo": "bar",
    });
    req.respnse.write("Hello, World! ${req.params.dynamic}");
  });

  app.listen(port, (iport, server) => print("Listening on $iport"));
}
