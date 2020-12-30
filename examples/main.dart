import 'package:responder/responder.dart';

var app = Responder();
var port = 3000;

void main() {
  app.listen(port, (iport, server) => print("Listening on $iport"));

  app.get('/a{dynamic}/route', (req, res) {
    res.headers({
      "Content-type": "application/json",
      "x-foo": "bar",
    });
    res.send("Hello, World! ${req.params.dynamic}");
  });
}
