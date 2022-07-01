import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'MainPage.dart';
import 'Task.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

const double windowWidth = 1200;
const double windowHeight = 800;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'REPORT APP',
      theme: ThemeData(
        primarySwatch: Colors.grey,

      ),
      home: const MyHomePage(),
    );
  }
}
List<Task> tasksN = [];
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //loadTasks();

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Haftalık Görev Dağılımı'),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      body: MainPage()
    );
  }

}
