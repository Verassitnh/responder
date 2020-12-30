# Responder
A tiny lightning fast server-side framework for dart.
## Getting Started
```dart
import 'package:responder/responder.dart';
var app = new Responder();

app.get('/a{dynamic}/route', (req, res) {
  res.headers({
    "Content-type": "application/json",
    "x-foo": "bar",
  })
  res.send("Hello, World! ${req.params.dynamic}")
});

app.listen(3000, (port) => print("listening on $address"));
```
# API Reference
## `Responder(options)`
Returns a `Responder` object.
```dart
Map options = {
    "logger": false,
    "ignoreTrailingSlash": true,
}
```
### `.options`
### `.get(route, Function(Request, Response))`
### `.post`
### `.put`
### `.delete`
### `.head`
### `.options`
### `.patch`
## `Request`
#### `.id`
#### `.params`
#### `.headers`
#### `.hostname`
#### `.method`
#### `.protocol`
#### `.url`
#### `.body`
#### `.query`
#### `.is404`
## `Response`
#### `.code`
#### `.header(name, value)`
#### `.headers(Map<Name, Value>)`
#### `.getHeaders()`
#### `.type(type)`
#### `.hasHeader(headerName)`
#### `.removeHeader(headerName)`
#### `.redirect(code, dest)`
#### `.send(data)`
#### `.sent`