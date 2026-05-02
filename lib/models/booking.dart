import 'dart:convert';

import 'package:heal_link_manange/models/user.dart';

class BookingModel {
  final String id;
  final String counselorId;
  final String userId;
  final String consultationType;
  final String startTime;
  final String endTime;

  BookingModel({
    required this.id,
    required this.counselorId,
    required this.userId,
    required this.consultationType,
    required this.startTime,
    required this.endTime,
  });

  //convert to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'counselorId': counselorId,
    'userId': userId,
    'consultationType': consultationType,
    'startTime': startTime,
    'endTime': endTime,
  };
  //convert to json
  String toJson() => jsonEncode(toMap());
  //convert to Object
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['_id'] as String? ?? "",
      counselorId: map['counselorId'] as String? ?? "",
      userId: map['userId'] as String? ?? "",
      //userId: map['userId'] as User? ?? User(),
      consultationType: map['consultationType'] as String? ?? "",
      startTime: map['startTime'] as String? ?? "",
      endTime: map['endTime'] as String? ?? "",
    );
  }
  // json to Map
  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(jsonDecode(source));
}
