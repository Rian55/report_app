import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/trello_card.dart';

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
  List<trello_card> _tasks = [];

  @override
  Widget build(BuildContext context)  {
    getTasks();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80.0,
            child: ListView.separated(
              itemCount: widget.members.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){

                return ElevatedButton(
                  onPressed: () {
                    setState(() {


                    });
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(40, 40),
                    shape: const CircleBorder(),
                    primary: Color(0xFF861BFD),
                  ),
                  child: Text(
                    get_initials(index),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index){
                return const SizedBox(width: 5,);
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: _tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, int index){
                return _tasks[index];
              },
              separatorBuilder: (context, index){
                return Divider();
              },
            ),
          )
        ],
      ),
    );
  }

  Future getTasks() async{
    var data = await FirebaseFirestore.instance.collection('tasks').where("Board", isEqualTo: widget.name).get();
    _tasks = List.from(data.docs.map((doc) => trello_card.fromSnapshot(doc)));
  }

  String get_initials(int index){
    final re = RegExp(r'^.');
    String rtrn = "";
    List<String?> fullName = ["0"];
    fullName = widget.members[index].split(" ");
    for(int i = 0; i < fullName.length; i++){
      rtrn += re.stringMatch(fullName[i]!)!;
    }
    return rtrn;
  }
}