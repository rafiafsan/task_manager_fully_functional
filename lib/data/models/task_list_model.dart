import 'package:task_manager_fully_functional/data/models/task_model.dart';

class TaskListModel{
  late final String status;
  late final List<TaskModel> taskList;

  TaskListModel.fromJson(Map<String,dynamic> JsonData) {
    status =JsonData['status'];
    if(JsonData['data'] != null){
      List<TaskModel> list =[];
      for(Map<String,dynamic> data in JsonData['data']){
        list.add(TaskModel.fromJson(data));
      }
      taskList = list;
    }else{
      taskList = [];
    }
  }
}