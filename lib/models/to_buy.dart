// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ToBuy {
  final String id;
  final String title;
  final String description;

  ToBuy({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ToBuy.fromMap(Map<String, dynamic> map) {
    return ToBuy(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
