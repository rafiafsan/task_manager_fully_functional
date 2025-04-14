import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/data/models/task_status_count_list_model.dart';
import 'package:task_manager_fully_functional/data/models/task_status_count_model.dart';
import 'package:task_manager_fully_functional/data/service/network_client.dart';
import 'package:task_manager_fully_functional/data/utils/urls.dart';
import 'package:task_manager_fully_functional/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_fully_functional/ui/widgets/snack_bar_message.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList =[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAllTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSummarySection(),
            ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return const TaskCard(
                    taskStatus: TaskStatus.sNew,
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTapTaskScreen,
        child: Icon(Icons.add),
      ),
    );
  }

  void onTapTaskScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _taskStatusCountList.length,
            itemBuilder: (context, index) {
              return SummaryCard(
                  title: _taskStatusCountList[index].status,
                  count: _taskStatusCountList[index].count);
            }),
      ),
      // child: Row(
      //   children: [
      //     SummaryCard(
      //       title: "New",
      //       count: 12,
      //     ),
      //     SummaryCard(
      //       title: "Progess",
      //       count: 4,
      //     ),
      //     SummaryCard(
      //       title: "Completed",
      //       count: 3,
      //     ),
      //     SummaryCard(
      //       title: "Cancelled",
      //       count: 7,
      //     ),
      //   ],
      // ),
    );
  }

  Future<void> _getAllTaskStatusCount() async {
    _getStatusCountInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkClient.getRequest(url: Urls.taskStatusCountUrl);

    if(response.isSuccess){
      TaskStatusCountListModel taskStatusCountListModel =
          TaskStatusCountListModel.fromJson(response.data ?? {});
      _taskStatusCountList = taskStatusCountListModel.statusCountList;
    }else{
      showSnackBar(context, response.errorMessage,true);
    }

    _getStatusCountInProgress = false;
    setState(() {});
  }
}
