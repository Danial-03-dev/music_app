import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String id;
  final String token;

  const UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.token,
  });

  UserModel copywith({String? name, String? email, String? id, String? token}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      '_id': id,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final user = map['user'];
    final token = map['token'];

    return UserModel(
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      id: user['_id'] ?? '',
      token: token ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String user) =>
      UserModel.fromMap(json.decode(user) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, id: $id, token: $token)';
}
