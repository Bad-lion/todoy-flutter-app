class Task {
  int id;
  String name;

  Task(this.id, this.name);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}
