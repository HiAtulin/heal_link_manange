import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;
  final String avatar;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
    required this.avatar,
  });

  //convert to map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      'email': email,
      'phone': phone,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
      'avatar': avatar,
    };
  }

  //convert to json
  String toJson() => json.encode(toMap());

  //convert to Object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      phone: map['phone'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
      avatar: map['avatar'] as String? ?? "",
    );
  }

  // json to Map
  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);

  // copyWith method
  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? state,
    String? city,
    String? locality,
    String? password,
    String? token,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      state: state ?? this.state,
      city: city ?? this.city,
      locality: locality ?? this.locality,
      password: password ?? this.password,
      token: token ?? this.token,
      avatar: avatar ?? this.avatar,
    );
  }
}
