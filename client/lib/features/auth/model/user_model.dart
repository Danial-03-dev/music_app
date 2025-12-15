import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String id;

  const UserModel({required this.name, required this.email, required this.id});

  UserModel copywith({String? name, String? email, String? id}) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'email': email, '_id': id};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final user = map['user'];

    return UserModel(
      name: user['name'] ?? '',
      email: user['email'] ?? '',
      id: user['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String user) =>
      UserModel.fromMap(json.decode(user) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(name: $name, email: $email, id: $id)';
}
