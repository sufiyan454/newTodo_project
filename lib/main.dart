import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp_project/View/todoapp_page.dart';
import 'package:todoapp_project/provider_model/provider_tool.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => TodoProvider(),
      child: MaterialApp(
        home: TodoApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
     
  }
}


