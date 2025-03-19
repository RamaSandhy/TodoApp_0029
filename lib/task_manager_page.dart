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
      title: 'Task Manager',
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

  void toggleTaskStatus(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Form Page',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Task Date:'),
              Row(
                children: [
                  Text(
                    'Select a date',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Color.fromARGB(255, 34, 245, 10)),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text('First Name'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your first name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  ElevatedButton(
                    onPressed: addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 109, 249, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'List Tasks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: tasks.isEmpty 
                  ? const Center(child: Text('No tasks yet')) 
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 4),
                                    Text(
                                      'Deadline: ${_formatDate(task.deadline)}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),

                                    Text(
                                      task.isDone ? 'Done' : 'Not Done',
                                      style: TextStyle(
                                        color: task.isDone ? Colors.green : Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                               Checkbox(
                                value: task.isDone,
                                onChanged: (_) => toggleTaskStatus(index),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
              ),




                                    