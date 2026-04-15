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
    id: map['_id']?.toString() ?? '',
    fullName: map['fullName']?.toString() ?? '',
    gender: map['gender']?.toString() ?? '',
    age: map['age'] is int
        ? map['age']
        : int.tryParse(map['age']?.toString() ?? '0') ?? 0,
    phone: map['phone']?.toString() ?? '',
    password: map['password']?.toString() ?? '',
    email: map['email']?.toString() ?? '',
    title: map['title']?.toString() ?? '',
    major: map['major'] is List<String>
        ? map['major'] as List<String>
        : (map['major'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
              [],
    qualification: map['qualification'] is List<String>
        ? map['qualification'] as List<String>
        : (map['qualification'] as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
    experience: map['experience'] is int
        ? map['experience']
        : int.tryParse(map['experience']?.toString() ?? '0') ?? 0,
    introduction: map['introduction']?.toString() ?? '',
    status: map['status']?.toString() ?? '',
    avatar: map['avatar']?.toString() ?? '',
    createdAt: map['createdAt']?.toString() ?? '',
    updatedAt: map['updatedAt']?.toString() ?? '',
  );

  factory Counselor.fromJson(String json) =>
      Counselor.fromMap(jsonDecode(json));
}
