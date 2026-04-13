import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/provider_model/provider_tool.dart';
import '../models/todo_model.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final TextEditingController controller = TextEditingController();

  void editTask(BuildContext context, Todo task) {
    final TextEditingController editController = TextEditingController(
      text: task.title,
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit Task"),
        content: TextField(controller: editController),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              task.title = editController.text;
              Provider.of<TodoProvider>(context, listen: false);

              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("To-Do List", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Enter new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.add, color: Colors.white, size: 35),
                    onPressed: () {
                      provider.addTask(controller.text);
                      controller.clear();
                    },
                  ),
                ),
              ],
            ),
          ),

          Divider(),
          Padding(
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Pending Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: provider.pendingTasks.length,
              itemBuilder: (context, index) {
                final task = provider.pendingTasks[index];

                return Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      leading: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: false,
                          onChanged: (_) => provider.toggleTask(task),
                        ),
                      ),
                      title: Text(task.title, style: TextStyle(fontSize: 20)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 28),
                            onPressed: () => editTask(context, task),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, size: 28),
                            onPressed: () => provider.deleteTask(task),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Completed",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Divider(),

          Expanded(
            child: ListView.builder(
              itemCount: provider.completedTasks.length,
              itemBuilder: (context, index) {
                final task = provider.completedTasks[index];

                return Column(
                  children: [
                    ListTile(
                      leading: Transform.scale(
                        scale: 1.5,
                        child: Checkbox(
                          value: true,
                          onChanged: (_) => provider.toggleTask(task),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      title: Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, size: 28),
                        onPressed: () => provider.deleteTask(task),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // rectangle
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: provider.clearCompleted,
                    child: const Text(
                      "Clear Completed",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 45,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onPressed: provider.deleteAll,
                    child: const Text(
                      "Delete All",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
