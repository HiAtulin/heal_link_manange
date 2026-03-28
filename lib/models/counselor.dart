import 'dart:convert';

class Counselor {
  final String id;
  final String fullName;
  final String gender;
  final int age;
  final String phone;
  final String password;
  final String email;
  final String title;
  final List<String> major;
  final List<String> qualification;
  final int experience;
  final String introduction;
  final String status;
  final String avatar;
  final String createdAt;
  final String updatedAt;

  Counselor({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.phone,
    required this.password,
    required this.email,
    required this.title,
    required this.major,
    required this.qualification,
    required this.experience,
    required this.introduction,
    required this.status,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'fullName': fullName,
    'gender': gender,
    'age': age,
    'phone': phone,
    'password': password,
    'email': email,
    'title': title,
    'major': major,
    'qualification': qualification,
    'experience': experience,
    'introduction': introduction,
    'status': status,
    'avatar': avatar,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  String toJson() => jsonEncode(toMap());

  factory Counselor.fromMap(Map<String, dynamic> map) => Counselor(
    id: map['_id'] ?? '',
    fullName: map['fullName'] ?? '',
    gender: map['gender'] ?? '',
    age: map['age'] ?? 0,
    phone: map['phone'] ?? '',
    password: map['password'] ?? '',
    email: map['email'] ?? '',
    title: map['title'] ?? '',
    major: map['major'] ?? [],
    qualification: map['qualification'] ?? [],
    experience: map['experience'] ?? 0,
    introduction: map['introduction'] ?? '',
    status: map['status'] ?? '',
    avatar: map['avatar'] ?? '',
    createdAt: map['createdAt'] ?? '',
    updatedAt: map['updatedAt'] ?? '',
  );

  factory Counselor.fromJson(String json) =>
      Counselor.fromMap(jsonDecode(json));
}
