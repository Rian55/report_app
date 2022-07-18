import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/trello_card.dart';
import 'firebase_options.dart';
import 'screens/home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

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
List<trello_card> tasksN = [];
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //loadTasks();

    return Scaffold(
      backgroundColor: Color(0xfff0f0e2),
      body: home()
    );
  }

}
