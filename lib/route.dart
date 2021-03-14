class Query {
  Map<String, String> params;
  Map<String, String> query;
}

class Route {
  Route(this.pattern);

  final String pattern;

  Query init(String path) {
    if (path == "" || pattern == "") return null;
    if (!path.startsWith("/")) throw "Path must start with \"/\"";
    if (!pattern.startsWith("/")) throw "Path pattern must start with \"/\"";

    var pathSegments = path.split("/");
    var patternSegments = path.split("/");

    for (var index = 0; index <= patternSegments.length; index++) {}
  }
}
