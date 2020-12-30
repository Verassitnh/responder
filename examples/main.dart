import 'package:responder/responder.dart';

var app = new Responder();

app.get('/a{dynamic}/route', (req, res) {
  res.headers({
    "Content-type": "application/json",
    "x-foo": "bar",
  })
  res.send("Hello, World! ${req.params.dynamic}")
})

app.listen(3000, (port,) => print("listening on $address"));