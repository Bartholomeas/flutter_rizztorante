import 'dart:convert';

import 'package:flutter_restaurant/data/network/constants/endpoints.dart';
import 'package:flutter_restaurant/data/network/dio_client.dart';

class ApiProvider {
  final _dioClient = DioClient();

  Future<Map<String, dynamic>> postLogin(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> requestBody = {"email": email, "password": password};

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

  Future<dynamic> getCart() async {
    try {
      final response = await _dioClient.get(Endpoints.cart);
      if (response != null) {
        return response;
      }
      throw Exception('Null response from server');
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> addToCart(
      {required String menuPositionId, int? quantity = 1}) async {
    try {
      Map<String, dynamic> requestBody = {
        "menuPositionId": menuPositionId,
        "quantity": quantity,
        "confiruableIngredients": []
      };
      final response =
          await _dioClient.post(Endpoints.addToCart, data: requestBody);
      if (response != null) {
        return response;
      }
      throw Exception('Null response from server');
    } catch (err) {
      rethrow;
    }
  }

  Future<List<dynamic>> getMenus() async {
    try {
      final response = await _dioClient.get(Endpoints.menus);
      if (response != null) {
        return response;
      }

      throw Exception('Null response from server');
    } catch (err) {
      rethrow;
    }
  }

  Future<List<dynamic>> getMenuCategory(String menuId) async {
    try {
      final response = await _dioClient.get(Endpoints.menuCategory(menuId));
      if (response != null) {
        return response;
      }

      throw Exception('Null response from server');
    } catch (err) {
      rethrow;
    }
  }

  Future<dynamic> getMenuPositionDetails(String positionId) async {
    try {
      final response =
          await _dioClient.get(Endpoints.menuPositionDetails(positionId));
      if (response != null) {
        return response;
      }
      throw Exception('Null response from server');
    } catch (err) {
      print('Error in getMenuPositionDetails: $err');
      rethrow;
    }
  }
}
