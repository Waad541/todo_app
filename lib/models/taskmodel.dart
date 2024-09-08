class TaskModel {
  String id;
  String title;
  bool isDone;
  String subtitle;
  int date;
  String userId;

  TaskModel({
    this.id = '',
    required this.title,
    this.isDone = false,
    required this.subtitle,
    required this.date,
    required this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          subtitle: json['subtitle'],
          date: json['date'],
          id: json['id'],
          isDone: json['isDone'],
          userId: json['userId'],
        );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'id': id,
      'isDone': isDone,
      "userId": userId,
    };
  }
}
