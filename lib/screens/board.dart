import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/member_list.dart';
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
  String current_member = "all";
  String current_list = "All";
  List<trello_card> _tasks = [];
  String selectval = "All";

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant trello_board oldWidget) {

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context)  {

    return Scaffold(
      backgroundColor: Color(0xFFDEDEDE),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color(0xFF000030),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 21),
        title: Text(widget.name),
        actions: [
          ElevatedButton(
            ///TODO:: remove elevation after pressing button
            onPressed: (){},
            style: ElevatedButton.styleFrom(elevation: 0, primary: Color(0xFF000030)),
            child: DropdownButtonHideUnderline (
              child: DropdownButton(
                dropdownColor: Color(0xFF307473),
                style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "Monsterrat"),
                elevation: 0,
                items: get_menu(),
                value: selectval.isNotEmpty ? selectval : null,
                icon: Icon(Icons.sort),
                iconEnabledColor: Colors.white,
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
            height: 85.0,
            child:  member_list(members: widget.members, function: set_current_member, SIZE: 40,)
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){add_card_dialog(context);},
        backgroundColor: Color(0xFF000030),
        child: const Icon(Icons.add, color: Colors.white,),
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
    rtrn.add(const DropdownMenuItem(value: "All",child: Text("All"),));
    for(var i in widget.lists) {
      rtrn.add(DropdownMenuItem(value: i,child: Text(i),));
    }
    return rtrn;
  }

  void set_current_member(String member_name){
    setState((){
      if(current_member != member_name)
        current_member = member_name;
      else
        current_member = "all";
    });
  }

  void add_card_dialog(BuildContext context){
    showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 24.0),
        title: const Text("Add Task"),
        content: Container(
          height: 320,
          child: Column(
            children: [

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Close"))
        ],
      );
    }
    );
  }
}