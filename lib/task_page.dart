import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskManager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TaskManagerPage(),
    );
  }
}

class Task {
  final String title;
  final DateTime deadline;
  bool isDone;

  Task({
    required this.title,
    required this.deadline,
    this.isDone = false,
  });
}

class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({super.key});

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  final TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  // Empty list of tasks
  List<Task> tasks = [];

  bool showSuccessMessage = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

void addTask() {
    if (nameController.text.isNotEmpty) {
      setState(() {
        tasks.add(Task(
          title: nameController.text,
          deadline: selectedDate,
        ));
        nameController.clear();
        showSuccessMessage = true;

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            showSuccessMessage = false;
          });
        });
      });
    }
  }
}




