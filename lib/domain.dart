import 'dart:convert';

class Task {
  int? id;

  String description;
  bool completed;

  Task(this.description, {this.completed = false, this.id});

  Task copyWith({String? description, bool? completed}) {
    return Task(
      description ?? this.description,
      completed: completed ?? this.completed,
      id: id,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['description'],
      completed: json['completed'],
      id: json['id'],
    );
  }

  static Task fromJsonString(String jsonString) {
    return Task.fromJson(json.decode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'completed': completed,
      'id': id,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Task &&
        other.description == description &&
        other.completed == completed;
  }

  @override
  int get hashCode => Object.hash(description, completed);
}

class TaskException implements Exception {
  final String message;

  TaskException(this.message);

  @override
  String toString() {
    return message;
  }
}
