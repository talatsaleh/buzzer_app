import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String phone;

  const User({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'orders': [],
    };
  }

  factory User.fromMap(Map<String, dynamic> map, String uid) {
    return User(id: uid, name: map['name'], phone: map['phone']);
  }

  factory User.fromMapLocal(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], phone: map['phone']);
  }

  @override
  List<Object?> get props => [id, name, phone];
}
