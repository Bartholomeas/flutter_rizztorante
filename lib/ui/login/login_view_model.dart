import 'package:flutter/cupertino.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();
  ApiState apiState = ApiState.completed;

  int cl = 0;
  Future<void> increaseNumber(int cntr) async {
    cl = cntr + 10;
    apiState = ApiState.loading;
    notifyListeners();

    var l = await _apiProvider.postLogin();
    print("Token::: " + l.token);
    notifyListeners();
  }
}

enum ApiState { loading, completed, error }
