import 'package:my_schedule/src/models/date.dart';

class Todo {
  String title;
  String description;
  Date date;
  bool isDone;

  Todo({
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });
}
