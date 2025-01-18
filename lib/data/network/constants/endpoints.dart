class Endpoints {
  Endpoints._();

  static const String baseUrl = "http://162.19.153.39:3002/api/v1/";

  static const int receiveTimeout = 5000;
  static const int connectionTimeout = 3000;

  static const String login = "${baseUrl}auth/login";

  static const String menus = "${baseUrl}menus";

  static const String cart = "${baseUrl}cart";
  static const String addToCart = "${baseUrl}cart/item";

  static String menuCategory(String menuId) =>
      "${baseUrl}menus/$menuId/categories";

  static String menuPositionDetails(String positionId) =>
      "${baseUrl}menus/positions/$positionId";

  static const String logout = "${baseUrl}auth/logout";
}
