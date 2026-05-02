import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heal_link_manange/global_variables.dart';
import 'package:heal_link_manange/models/booking.dart';
import 'package:heal_link_manange/models/user.dart';
import 'package:heal_link_manange/provider/booking_provider.dart';
import 'package:heal_link_manange/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class BookingController {
  Future<void> addBooking({
    required BuildContext context,
    required String counselorId,
    required String userId,
    required String consultationType,
    required String startTime,
    required String endTime,
  }) async {
    try {
      BookingModel booking = BookingModel(
        id: '',
        counselorId: counselorId,
        userId: userId,
        consultationType: consultationType,
        startTime: startTime,
        endTime: endTime,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/add-booking'),
        body: booking.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          final bookingJson = jsonEncode(jsonDecode(response.body)['booking']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
      print("Error: $e");
    }
  }

  Future<List<BookingModel>> getBookingsByCounselor({
    required BuildContext context,
    required String counselorId,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-bookings-by-counselor/$counselorId'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BookingModel> bookings = data
            .map((booking) => BookingModel.fromMap(booking))
            .toList();
        return bookings;
      } else {
        throw Exception("获取咨询师预约失败，状态码：${response.statusCode}");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
      print("Error: $e");
    }
    return [];
  }
}
