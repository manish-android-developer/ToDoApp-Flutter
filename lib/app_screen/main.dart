import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../todo_provider/TaskProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: ToDoApp(),
    ),
  );
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Center(
        child: Text(
          'Manage Your To-Do List',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      taskProvider.addTask(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.tasks.length,
                  itemBuilder: (context, index) {
                    final task = provider.tasks[index];
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 50, // Adjust size as needed
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: task.isComplete
                                  ? Colors.green
                                  : Colors.red, // Border color based on status
                              width: 2, // Border width
                            ),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/todo.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          task.title,
                          style: TextStyle(
                              decoration: task.isComplete
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          task.isComplete ? '🟢 Complete' : '🔴 Pending',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: task.isComplete ? Colors.green : Colors.red,
                          ),
                        ),
                        trailing: Checkbox(
                          value: task.isComplete,
                          onChanged: (bool? value) {
                            provider.toggleTaskCompletion(task);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
