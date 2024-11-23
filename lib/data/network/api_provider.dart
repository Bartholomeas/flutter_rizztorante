import 'dart:convert';

import 'package:flutter_restaurant/data/network/constants/Endpoints.dart';
import 'package:flutter_restaurant/data/network/dio_client.dart';

class ApiProvider {
  final _dioClient = DioClient();

  Future<dynamic> postLogin() async {
    try {
      Map<String, dynamic> requestBody = {
        "email": "test@gmail.com",
        "password": "!23Haslo"
      };

      final response =
          await _dioClient.post(Endpoints.login, data: requestBody);

      if (response != null) {
        if (response is String) {
          return jsonDecode(response);
        }
        return response;
      }
      throw Exception('Null response from server');
    } catch (err) {
      print('Login error in ApiProvider: $err');

      rethrow;
    }
  }
}
