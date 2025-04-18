import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        ListView.separated(
            itemCount: 7,
            itemBuilder: (context, index) {
              // return const TaskCard(taskStatus: TaskStatus.cancelled,);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 8,
            )
        )

    );
  }
}
