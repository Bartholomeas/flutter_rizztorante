import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();
  ApiState apiState = ApiState.initial;
  UserModel? currentUser;

  bool get isLoggedIn => currentUser != null;

  Future<bool> login(String email, String password) async {
    apiState = ApiState.loading;
    notifyListeners();

    try {
      var response =
          await _apiProvider.postLogin(email: email, password: password);

      currentUser = UserModel.fromJson(response);
      apiState = ApiState.success;
      notifyListeners();
      return true;
    } catch (err) {
      if (kDebugMode) {
        print("Login error::: $err");
      }
      apiState = ApiState.error;
      notifyListeners();
      return false;
    }
  }

  int cl = 0;
  Future<void> increaseNumber(int cntr) async {
    try {
      cl = cntr + 10;
      apiState = ApiState.loading;
      notifyListeners();
      apiState = ApiState.success;
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

enum ApiState { initial, loading, success, error }
