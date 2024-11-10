class Task {
  int? id;
  String title;
  bool isComplete;

  Task({this.id, required this.title, this.isComplete = false});

  // Convert Task to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isComplete': isComplete ? 1 : 0,
    };
  }

  // Factory constructor to create Task from a map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      isComplete: map['isComplete'] == 1,
    );
  }
}
