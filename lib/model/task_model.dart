class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String duration;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
  });

  factory TaskModel.fromJson({required Map<String, dynamic> map}) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      duration: map['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duration': duration,
    };
  }
}
