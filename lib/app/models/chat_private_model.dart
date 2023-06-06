import 'dart:convert';

import 'package:flutter/foundation.dart';



class ChatPrivateModel {
  
  final List<String> users;
 
  ChatPrivateModel({
    required this.users,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': users,
    };
  }

  factory ChatPrivateModel.fromMap(Map<String, dynamic> map) {
    
   final list = map['users'] as List<dynamic>;
   final users = list.map((e) => e.toString()).toList();
    
    return ChatPrivateModel(
      users: users
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatPrivateModel.fromJson(String source) => ChatPrivateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ChatPrivateModel copyWith({
    List<String>? users,
  }) {
    return ChatPrivateModel(
      users: users ?? this.users,
    );
  }

  @override
  String toString() => 'ChatPrivateModel(users: $users)';

  @override
  bool operator ==(covariant ChatPrivateModel other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.users, users);
  }

  @override
  int get hashCode => users.hashCode;
}
