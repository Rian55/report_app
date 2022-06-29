import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,

      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Görevler Listesi'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Yapılması Gerekenler'),
              Tab(text: 'Başladım'),
              Tab(text: 'Kontrol Edilmeli'),
              Tab(text: 'Bitti'),
              Tab(text: 'Düzeltilecek'),
              Tab(text: 'SABİT GÖREVLER'),
              Tab(text: 'Her Cuma/Hafta'),
              Tab(text: 'Her Ay'),
            ],
          ),
        ),

      ),
    );
  }
}