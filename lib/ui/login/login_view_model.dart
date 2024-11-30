import 'package:flutter/foundation.dart';
import 'package:flutter_restaurant/data/network/api_provider.dart';
import 'package:flutter_restaurant/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant/ui/main/main_page.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiProvider = ApiProvider();
  ApiState apiState = ApiState.initial;
  UserModel? currentUser;

  bool get isLoggedIn => currentUser != null;

  Future<bool> login(
      BuildContext context, String email, String password) async {
    apiState = ApiState.loading;
    notifyListeners();

    try {
      var response =
          await _apiProvider.postLogin(email: email, password: password);

      currentUser = UserModel.fromJson(response);
      apiState = ApiState.success;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainPage()));
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
}

enum ApiState { initial, loading, success, error }
