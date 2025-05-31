import 'package:intl/intl.dart';

class NoteModel {
  int? id;
  String title;
  int priority;
  String description;
  String time;

  NoteModel({
    this.id,
    required this.priority,
    required this.title,
    required this.description,
    required this.time
  });

  factory NoteModel.fromMapObj(Map<String, dynamic> mapObj) {
    return NoteModel(
        id: mapObj['id'],
        priority: mapObj['priority'],
        title: mapObj['title'],
        description: mapObj['description'],
        time: mapObj['time']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
      'priority': priority,
      'description': description,
      'time': time
    };
  }
}
