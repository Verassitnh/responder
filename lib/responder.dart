import 'dart:io';

extension on Uri {
  safePath() {
    var pathArr = new List<String>.from(this.path.split(""));
    if (pathArr.last == '/') {
      pathArr.removeLast();
      return pathArr.join("");
    } else {
      return this.path;
    }
  }
}

class Url {
  Url(this._key, this._path);

  final String _key;
  final String _path;
  final RegExp regex = RegExp(r"\{[a-zA-Z]+\}");
  bool check() {
    if (regex.hasMatch(this._key)) {
      String regString = r"^" + this._key.split(regex).join(r"\w+") + r"$";
      regString = regString.replaceAll(r"/", r"\/");
      return RegExp(regString).hasMatch(this._path);
    } else {
      return this._key == this._path;
    }
  }

  Map<String, String> options() {
    // Vars
    List<String> values = List<String>();
    Map<String, String> result = Map<String, String>();
    var keys = this._key.split(regex);

    if (regex.hasMatch(this._key)) {
      // Find Option Values
      String regString = r"^" + this._key.split(regex).join(r"\w+") + r"$";
      keys.forEach((element) {
        var result = this._path.replaceAll(element, "?");
        if (result.endsWith("?")) {
          var chars = result.split("").toList();
          chars.removeLast();
          result = chars.join();
        }
        var matchesWithQuestionMark =
            RegExp(r"\?\w*\?").allMatches(result).toList();
        matchesWithQuestionMark.forEach(
            (match) => {values.add(match.toString().replaceAll("?", ""))});
      });

      // Find Option keys
      regex.allMatches(this._key).forEach((element) {
        String key = element.toString();
        List<String> stringArr = key.split("").toList();
        stringArr.removeLast();
        stringArr.removeAt(0);
        key = stringArr.join("");
        keys.add(key);
      });
      int index = 0;
      keys.forEach((key) {
        print(values);
        print(keys);
        result[key] = values[index];
        index++;
      });
    }
    return result;
  }
}

class Responder {
  Responder({this.endpoints});

  Function e404;

  // final HttpRequest req;
  final Map<String, Function(HttpRequest req, Map<String, String> options)>
      endpoints;

  serve(int port, Function(int port) callback) async {
    HttpServer server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    callback(port);
    await for (var request in server) {
      _handleEndpoints(request);
    }
  }

  _handleEndpoints(HttpRequest req) {
    bool handled = false;
    endpoints.forEach((key, value) {
      Url path = new Url(key, req.uri.safePath());
      if (path.check()) {
        handled = true;
        value(req, path.options());
        req.response.close();
      }
    });
    if (!handled) {
      if (e404 != null) {
        req.response.statusCode = 404;
        e404(req);
        req.response.close();
      } else {
        req.response.statusCode = 404;
        req.response.write("Error 404 - No Handler for: ${req.uri.path}");
        req.response.close();
      }
    }
  }
}
