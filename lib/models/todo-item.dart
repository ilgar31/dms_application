import 'package:dms_project/models/model.dart';

class TodoItem extends Model {

  static String table = 'todo_items';

  var id;
  var task;
  var complete;

  TodoItem({ this.id, this.task, this.complete });

  Future<Map<dynamic, dynamic>> toMap() async {

    Map<dynamic, dynamic> map = {
    'task': task,
    'complete': complete
    };

    if (id != null) { map['id'] = id; }
    return map;
  }

  static TodoItem fromMap(Map<dynamic, dynamic> map) {

  return TodoItem(
  id: map['id'],
  task: map['task'],
  complete: map['complete'] == 1
  );
  }
}
