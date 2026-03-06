enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  bookmark("/bookmark");

  const NavigationRoute(this.name);
  final String name;
}
