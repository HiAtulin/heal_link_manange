import 'dart:convert';

import 'package:heal_link_manange/global_variables.dart';
import 'package:heal_link_manange/models/user.dart';
import 'package:http/http.dart' as http;

class UserController {
  Future<List<User>> getUsers({required String counselorId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/users/$counselorId'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<User> users = data.map((user) => User.fromMap(user)).toList();
        print(666);
        print(users);
        return users;
      } else {
        throw Exception("获取用户失败，状态码：${response.statusCode}");
      }
    } catch (e) {
      throw Exception("获取用户失败，异常信息$e");
    }
  }
}
