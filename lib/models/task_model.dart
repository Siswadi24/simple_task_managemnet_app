class TaskModel {
  int? id;
  String? title;
  String? note;
  int? isComplete;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? reminder;
  String? repeatRemind;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.isComplete,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.reminder,
    this.repeatRemind,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isComplete = json['isComplete'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    reminder = json['reminder'];
    repeatRemind = json['repeatRemind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] ??= id;
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['isComplete'] = isComplete;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['color'] = color;
    data['reminder'] = reminder;
    data['repeatRemind'] = repeatRemind;
    return data;
  }
}
