// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String nickName;
  String name;
  String email;
  String avatar;
  String chatOpen;
  String curso;

  UserModel({
    this.nickName = "",
    this.name = "",
    required this.email,
    this.avatar = "",
    this.chatOpen = "",
    this.curso = "",
  });

  UserModel copyWith({
    String? nickName,
    String? name,
    String? email,
    String? avatar,
    String? chatOpen,
    String? curso,
  }) {
    return UserModel(
      nickName: nickName ?? this.nickName,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      chatOpen: chatOpen ?? this.chatOpen,
      curso: curso ?? this.curso,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickName': nickName,
      'name': name,
      'email': email,
      'avatar': avatar,
      'chatOpen': chatOpen,
      'curso': curso,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nickName: map['nickName'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      chatOpen: map['chatOpen'] as String,
      curso: map['curso'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(nickName: $nickName, name: $name, email: $email, avatar: $avatar, chatOpen: $chatOpen, curso: $curso)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.nickName == nickName &&
        other.name == name &&
        other.email == email &&
        other.avatar == avatar &&
        other.chatOpen == chatOpen &&
        other.curso == curso;
  }

  @override
  int get hashCode {
    return nickName.hashCode ^
        name.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        chatOpen.hashCode ^
        curso.hashCode;
  }
}
