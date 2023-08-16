import 'package:get/get.dart';
import 'package:managemen_task_app/db/db_helper.dart';
import 'package:managemen_task_app/models/task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <TaskModel>[].obs;

  Future<int> addTask({TaskModel? taskModel}) async {
    return await DBHelper.insertTask(taskModel);
  }

  //Get All Task from DB
  void getAllTask() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map((data) => new TaskModel.fromJson(data)).toList(),
    );
  }

  //delete task
  void deleteTask(TaskModel taskModel) {
    DBHelper.delete(taskModel);
    getAllTask();
  }

  void markTaskComplete(int id) async {
    await DBHelper.update(id);
    getAllTask();
  }
}
