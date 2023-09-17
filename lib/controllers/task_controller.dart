import 'package:get/get.dart';
import 'package:todo_app/db/db_helper.dart';
import 'package:todo_app/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> tasklist = <Task>[].obs;

 Future<int> addtask({required Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> gettasks() async{
   final List<Map<String, dynamic>> tasks =  await DBHelper.query();
    tasklist.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
 void deletetasks() async{
   await DBHelper.delete;
   gettasks();
  }
  void updatetasks() async{
   await DBHelper.update;
   gettasks();
  }

}
