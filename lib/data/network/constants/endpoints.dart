class Endpoints {
  Endpoints._();

  static const String baseUrl = "http://162.19.153.39:3002/api/";

  static const int receiveTimeout = 5000;
  static const int connectionTimeout = 3000;

  static const String login = baseUrl + "login";
}
