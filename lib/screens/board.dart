import 'package:flutter/material.dart';

class trello_board extends StatefulWidget{
  final String name;
  final List<dynamic> members;
  final List<dynamic> lists;

  const trello_board ({ Key? key, required this.name, required this.members, required this.lists}): super(key: key);

  @override
  _trello_board createState() => _trello_board();

  trello_board.fromSnapshot(snapshot)
    :lists = snapshot.data()['Lists'],
    members = snapshot.data()['Members'],
    name = snapshot.data()['Name'];
}

class _trello_board extends State<trello_board> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}