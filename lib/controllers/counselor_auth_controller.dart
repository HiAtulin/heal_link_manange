import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/global_variables.dart';
import 'package:heal_link_manange/models/counselor.dart';
import 'package:heal_link_manange/pages/authentication/login_page.dart';
import 'package:heal_link_manange/provider/counselor_provider.dart';
import 'package:heal_link_manange/services/manage_http_response.dart';
import 'package:heal_link_manange/widgets/main_layout.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class CounselorAuthController {
  Future<void> registerCounselor({
    required String fullName,
    required String gender,
    required int age,
    required String phone,
    required String email,
    required String title,
    required List<String> major,
    required List<String> qualification,
    required String introduction,
    required String status,
    required String avatar,
    required String createdAt,
    required String updatedAt,
    required String password,
    required int experience,
    required context,
    required WidgetRef ref,
    required Function() onComplete,
  }) async {
    try {
      Counselor counselor = Counselor(
        id: '',
        fullName: fullName,
        gender: gender,
        age: age,
        phone: phone,
        email: email,
        password: password,
        title: title,
        major: major,
        qualification: qualification,
        experience: experience,
        introduction: introduction,
        status: status,
        avatar: avatar,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/counselor/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: counselor.toJson(),
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, '咨询师注册成功！');
          onComplete();
        },
      );
    } catch (e) {
      showSnackBar(context, '${e.toString()}');
      onComplete();
    }
  }

  Future<void> signInCounselor({
    required String email,
    required String password,
    required context,
    required WidgetRef ref,
    required Function() onComplete,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/counselor/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          print(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];
          await prefs.setString('auth_token', token);
          final counselorJson = jsonDecode(response.body)['counselor'];
          print(counselorJson);
          ref
              .read(counselorProvider.notifier)
              .setCounselor(jsonEncode(counselorJson));

          await prefs.setString('counselor', jsonEncode(counselorJson));

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainCounselorLayout(),
            ),
            (route) => false,
          );
          showSnackBar(context, '咨询师登录成功！');
          onComplete();
        },
      );
    } catch (e) {
      showSnackBar(context, '${e.toString()}');
      onComplete();
    }
  }

  Future<void> signOutUser({required context, required WidgetRef ref}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('auth_token');
      await preferences.remove('counselor');
      ref.read(counselorProvider.notifier).signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
      showSnackBar(context, "退出成功");
    } catch (e) {
      showSnackBar(context, e.toString());
      print("Error: $e");
    }
  }
}
