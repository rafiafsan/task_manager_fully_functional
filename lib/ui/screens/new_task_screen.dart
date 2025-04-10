import 'package:flutter/material.dart';
import 'package:task_manager_fully_functional/ui/screens/add_new_task_screen.dart';
import '../widgets/summary_card.dart';
import '../widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SummaryCard(
              title: "New",
              count: 12,
            ),
            SummaryCard(
              title: "Progess",
              count: 4,
            ),
            SummaryCard(
              title: "Completed",
              count: 3,
            ),
            SummaryCard(
              title: "Cancelled",
              count: 7,
            ),
          ],
        ),
      ),
    );
  }
}
