import 'package:cloud_firestore/cloud_firestore.dart';

class TodoData {
  Timestamp? createdAt;
  String? description;
  String? id;
  bool? isDone;
  String? title;

  TodoData({
    this.createdAt,
    this.description,
    this.id,
    this.isDone,
    this.title,
  });

  TodoData.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    description = json['description'];
    id = json['id'];
    isDone = json['isDone'];
    title = json['title'];
  }

  TodoData copyWith({
    Timestamp? createdAt,
    String? description,
    String? id,
    bool? isDone,
    String? title,
  }) =>
      TodoData(
        createdAt: createdAt ?? this.createdAt,
        description: description ?? this.description,
        id: id ?? this.id,
        isDone: isDone ?? this.isDone,
        title: title ?? this.title,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['description'] = description;
    map['id'] = id;
    map['isDone'] = isDone;
    map['title'] = title;
    return map;
  }
}
