import 'package:flutter_restaurant/data/network/constants/Endpoints.dart';
import 'package:flutter_restaurant/data/network/dio_client.dart';

class ApiProvider {
  final _dioClient = DioClient();

  Future<dynamic> postLogin() async {
    try {
      Map<String, dynamic> map = Map();
      map["email"] = "test@test.com";
      map["password"] = "!23Haslo";

      final res = await _dioClient.post(Endpoints.login, data: map);
      return res.toString(); //TODO: remove
      // return Login.fromMap(res)
    } catch (err) {
      rethrow;
    }
  }
}
