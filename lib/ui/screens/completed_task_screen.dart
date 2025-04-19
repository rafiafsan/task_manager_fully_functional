import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/data/models/task_model.dart';
import 'package:task_manager_fully_functional/ui/widgets/centered_circular_progress_ndicator.dart';
import '../../data/models/task_list_model.dart';
import '../../data/service/network_client.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool  _getCompletedTasksInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        Visibility(
          visible: _getCompletedTasksInProgress == false,
          replacement: CenteredCircularProgressNdicator(),
          child: ListView.separated(
              itemCount: _completedTaskList.length,
              itemBuilder: (context, index) {
                return TaskCard(
                  taskStatus: TaskStatus.completed,
                  taskModel: _completedTaskList[index],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 8,
              )
          ),
        )
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    _getCompletedTasksInProgress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkClient.getRequest(url: Urls.completedTaskListUrl);

    if (response.isSuccess) {
      TaskListModel taskListModel = TaskListModel.fromJson(response.data ?? {});
      _completedTaskList = taskListModel.taskList;
    } else {
      showSnackBar(context, response.errorMessage, true);
    }

    _getCompletedTasksInProgress = false;
    setState(() {});
  }
}
