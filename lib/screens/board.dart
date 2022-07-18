import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/trello_card.dart';

class trello_board extends StatefulWidget{
  String name = "";
  List<dynamic> members = [];
  List<dynamic> lists = [];

  trello_board ({ Key? key}): super(key: key);

  @override
  _trello_board createState() => _trello_board();

  trello_board.fromSnapshot(snapshot)
    :lists = snapshot.data()['Lists'],
    members = snapshot.data()['Members'],
    name = snapshot.data()['Name'];
}

class _trello_board extends State<trello_board> {
  String current_member = "";
  String current_list = "";
  List<trello_card> _tasks = [];
  String selectval = "All";

  @override
  Widget build(BuildContext context)  {
    getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          ElevatedButton(
            ///TODO:: remove elevation after pressing button
            onPressed: (){},
            style: ElevatedButton.styleFrom(elevation: 0),
            child: DropdownButtonHideUnderline (
              child: DropdownButton(
                elevation: 0,
                items: get_menu(),
                value: selectval.isNotEmpty ? selectval : null,
                icon: Icon(Icons.sort),
                onChanged: (value){
                  setState(() {
                    selectval = value.toString();
                    current_list = value.toString();
                  });
                },
              ),
            ),
        ),
        ]
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
                      if(current_member != widget.members[index])
                        current_member = widget.members[index];
                      else
                        current_member = "all";
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
            child: ListView.builder(
              itemCount: _tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, int index){
                if(current_member != "all" || current_list != "All") {
                  if(current_member == "all" && _tasks[index].list == current_list)
                    return _tasks[index];
                  else if(current_list == "All" && _tasks[index].members.contains(current_member))
                    return _tasks[index];
                  else if (_tasks[index].members.contains(current_member) && _tasks[index].list == current_list)
                    return _tasks[index];
                  else
                    return SizedBox();
                }
                return _tasks[index];
              },
            ),
          )
        ],
      ),
    );
  }

  Future getTasks() async{
    if(_tasks.length < 1) {
      var data = await FirebaseFirestore.instance
          .collection('tasks')
          .where("Board", isEqualTo: widget.name)
          .get();
      _tasks = List.from(data.docs.map((doc) => trello_card.fromSnapshot(doc)));
    }
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

  List<DropdownMenuItem<String>> get_menu() {
    List<DropdownMenuItem<String>> rtrn = [];
    for(var i in widget.lists) rtrn.add(DropdownMenuItem(child: Text(i), value: i,));
    rtrn.add(DropdownMenuItem(child: Text("All"), value: "All",));
    return rtrn;
  }
}