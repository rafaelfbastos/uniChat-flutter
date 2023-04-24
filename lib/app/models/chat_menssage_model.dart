// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:unichat/app/models/user_model.dart';

class ChatMenssageModel {
  String text;
  UserModel user;
  Timestamp timestamp;

  ChatMenssageModel({
    required this.text,
    required this.user,
    required this.timestamp,
  });

  ChatMenssageModel copyWith({
    String? text,
    UserModel? user,
    Timestamp? timestamp,
  }) {
    return ChatMenssageModel(
      text: text ?? this.text,
      user: user ?? this.user,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'user': user.toMap(),
      'timestamp': timestamp,
    };
  }

  factory ChatMenssageModel.fromMap(Map<String, dynamic> map) {
    return ChatMenssageModel(
      text: map['text'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      timestamp: map['timestamp'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMenssageModel.fromJson(String source) =>
      ChatMenssageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatMenssageModel(text: $text, user: $user, timestamp: $timestamp)';

  @override
  bool operator ==(covariant ChatMenssageModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.user == user &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode => text.hashCode ^ user.hashCode ^ timestamp.hashCode;
}
