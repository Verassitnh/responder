class Route {
  Route(this.route);

  final String route;

  match(String requestedPath) {
    return true;
  }
}
