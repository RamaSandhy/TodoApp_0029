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
      title: 'Counter Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  List<String> daftarCounter = [];
  int counter = 1;

  void _tambahCounter() {
    setState(() {
      daftarCounter.add("Counter $counter");
      counter++;
    });
  }

  void _kurangiCounter() {
    if (daftarCounter.isNotEmpty) {
      setState(() {
        daftarCounter.removeLast();
        counter--; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: daftarCounter.isEmpty
          ? const Center(child: Text('Data Kosong'))
          : ListView.builder(
              itemCount: daftarCounter.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(daftarCounter[index]),
                );
              },
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _kurangiCounter,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _tambahCounter,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}







