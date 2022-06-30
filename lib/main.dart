import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'MainPage.dart';
import 'Task.dart';


void main() {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Haftalık Görev Dağılımı'),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      body: const MainPage(tasks: [Task(title: "To invade Area51", lastActivity: "20.05.2022",
        dueDate: "12.08.2022", members: ["niggachu", "niggatar", "niggachila"], stage: "Düzeltilecek",)]),
      );
  }
}