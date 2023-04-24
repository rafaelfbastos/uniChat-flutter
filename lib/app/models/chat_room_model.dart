// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String name;
  String tema;
  Timestamp create;
  ChatRoomModel({
    required this.name,
    required this.tema,
    required this.create,
  });

  ChatRoomModel copyWith({
    String? name,
    String? tema,
    Timestamp? create,
  }) {
    return ChatRoomModel(
      name: name ?? this.name,
      tema: tema ?? this.tema,
      create: create ?? this.create,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'tema': tema,
      'create': create,
    };
  }

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      name: map['name'] as String,
      tema: map['tema'] as String,
      create: map['create'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  int get daysElapsed {
    Duration days = DateTime.now().difference(create.toDate());
    return days.inDays;
  }

  factory ChatRoomModel.fromJson(String source) =>
      ChatRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatRoomModel(name: $name, tema: $tema, create: $create)';

  @override
  bool operator ==(covariant ChatRoomModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.tema == tema && other.create == create;
  }

  @override
  int get hashCode => name.hashCode ^ tema.hashCode ^ create.hashCode;
}
