import 'package:flutter/material.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListView.separated(
              itemCount: 7,
              itemBuilder: (context, index) {
                return const TaskCard();
              },
              separatorBuilder: (context, index) => SizedBox(
                height: 8,
              )
          )

    );
  }
}
