import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/model/user_model.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();
  ApiState apiState = ApiState.completed;
  UserModel? currentUser;

  bool get isLoggedIn => currentUser != null;

  Future<void> login(String email, String password) async {
    try {
      apiState = ApiState.loading;
      notifyListeners();

      var response =
          await _apiProvider.postLogin(email: email, password: password);

      currentUser = UserModel.fromJson(response);
      apiState = ApiState.completed;
      notifyListeners();
    } catch (err) {
      apiState = ApiState.error;
      notifyListeners();
    }
  }

  int cl = 0;
  Future<void> increaseNumber(int cntr) async {
    try {
      cl = cntr + 10;
      apiState = ApiState.loading;
      notifyListeners();
      apiState = ApiState.completed;

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
