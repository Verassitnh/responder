import 'package:test/test.dart';
import 'package:responder/responder.dart';

var app = Responder({});
var message = "not called";
var port = 58642;

void main() {
  test('app.listen callback should be called', () async {
    await app.listen(port, (iport, server) {
      message = "called $iport";
      server.close();
    });
    expect(message, equals("called $port"));
  });
}
