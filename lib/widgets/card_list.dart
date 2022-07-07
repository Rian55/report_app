import 'package:flutter/material.dart';

class Card extends StatefulWidget{
  Card ({ Key? key}): super(key: key);

  @override
  _Card createState() => _Card();
}

class _Card extends State<Card>{

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}
