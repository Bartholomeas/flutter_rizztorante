import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();
  ApiState apiState = ApiState.completed;
  UserModel? currentUser;

  Future<void> login() async {}

  int cl = 0;
  Future<void> increaseNumber(int cntr) async {
    try {
      cl = cntr + 10;
      apiState = ApiState.loading;
      notifyListeners();

      var response = await _apiProvider.postLogin();
      if (response != null) {
        apiState = ApiState.completed;
      } else {
        apiState = ApiState.error;
      }

      notifyListeners();

      notifyListeners();
    } catch (err) {
      if (kDebugMode) {
        print("Login error::: " + err.toString());
      }
      apiState = ApiState.error;
      notifyListeners();
    }
  }
}

enum ApiState { loading, completed, error }
