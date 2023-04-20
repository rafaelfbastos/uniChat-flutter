import 'dart:convert';

class UserModel {
  String? name;
  String email;
  String? avatar;
  String chatOpen;

  UserModel({
    this.name,
    required this.email,
    this.avatar,
    required this.chatOpen,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? avatar,
    String? chatOpen,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      chatOpen: chatOpen ?? this.chatOpen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'avatar': avatar,
      'chatOpen': chatOpen,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      chatOpen: map['chatOpen'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, avatar: $avatar, chatOpen: $chatOpen)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email;
  }

  @override
  int get hashCode {
    return email.hashCode;
  }
}
