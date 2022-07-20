import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/member_list.dart';
import '../widgets/trello_card.dart';

class trello_board extends StatefulWidget{
  String name = "";
  List<dynamic> members = [];
  List<dynamic> lists = [];

  trello_board ({ Key? key}): super(key: key);

  @override
  _trello_board createState() => _trello_board();

  trello_board.fromSnapshot(snapshot, {Key? key})
    :lists = snapshot.data()['Lists'],
    members = snapshot.data()['Members'],
    name = snapshot.data()['Name'], super(key: key);
}

class _trello_board extends State<trello_board> {
  String current_member = "all";
  String current_list = "All";
  List<trello_card> _tasks = [];
  String selectval = "All";
  String dialogVal = "All";

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
      backgroundColor: const Color(0xFFDEDEDE),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF000030),
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 21),
        title: Text(widget.name),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return get_menu();
          },
            onSelected: (choice){
              current_list = choice.toString();
              setState(() {});
            },
            color: const Color(0xFF307473),
            icon: const Icon(Icons.sort, color: Colors.white),
          ),
        ]
      ),
      body: Column(
        children: [
           SizedBox(
              height: 85.0,
              child:  member_list(members: widget.members, function: set_current_member, SIZE: 40,),
           ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              shrinkWrap: true,
              itemBuilder: (context, int index){
                if(_tasks[index].removed) {
                  return const SizedBox();
                }
                if(current_member != "all" || current_list != "All") {
                  if(current_member == "all" && _tasks[index].list == current_list) {
                    return _tasks[index];
                  } else if(current_list == "All" && _tasks[index].members.contains(current_member)) {
                    return _tasks[index];
                  } else if (_tasks[index].members.contains(current_member) && _tasks[index].list == current_list) {
                    return _tasks[index];
                  } else {
                    return const SizedBox();
                  }
                }
                return _tasks[index];
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){add_card_dialog(context);},
        backgroundColor: const Color(0xFF000030),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void refresh(){
    setState(() {
    });
  }

  Future getTasks() async{
    if(_tasks.isEmpty) {
      var data = await FirebaseFirestore.instance
          .collection('tasks')
          .where("Board", isEqualTo: widget.name)
          .get();
      _tasks = List.from(data.docs.map((doc){
        trello_card newCard = trello_card.fromSnapshot(doc);
        newCard.setRefreshBoard(refresh);
        return newCard;
      }));
    }
    setState((){});
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

  List<PopupMenuItem<String>> get_menu() {
    List<PopupMenuItem<String>> rtrn = [];
    rtrn.add(const PopupMenuItem(value: "All",child: Text("All", style: TextStyle(color: Colors.white),),));
    for(var i in widget.lists) {
      rtrn.add(PopupMenuItem(value: i,child: Text(i, style: const TextStyle(color: Colors.white),),));
    }
    return rtrn;
  }

  void set_current_member(String memberName){
    setState((){
      if(current_member != memberName) {
        current_member = memberName;
      } else {
        current_member = "all";
      }
    });
  }

  void add_card_dialog(BuildContext context){
    String title = "";
    List<dynamic> members = [];
    DateTime dueDate = DateTime.now();
    final format = DateFormat("yyyy-MM-dd");

    showDialog(context: context, builder:(BuildContext context){
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 24.0),
            title: const Text("Add Task"),
            content: SingleChildScrollView(
              child: SizedBox(
                height: 280,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Task:"),
                        const SizedBox(width:10),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextField(
                            onChanged: (text){title = text;},

                          ),
                        ),
                    ]
                    ),

                    const SizedBox(height: 15,),

                    Row(
                      children: [
                        const Text("Asignees:"),
                        const SizedBox(width:10),
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF307473)),
                          child: PopupMenuButton(itemBuilder: (BuildContext context){
                            return widget.members.map((choice) {
                              return PopupMenuItem(value: choice.toString(),child: Text(choice.toString()),);
                            }).toList();
                          },
                            onSelected: (choice){
                              if(!members.contains(choice)) {
                                  members.add(choice);
                              }else{
                                members.remove(choice);
                              }
                              setState(() {});
                              },
                            icon: const Icon(Icons.add, color: Colors.white,),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15,),

                    SizedBox(
                      height: 45,
                      child: member_list(function: null, SIZE: 20, members: members),
                    ),

                    const SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Text('Due Date:   '),
                        Text("${dueDate.day}/${dueDate.month}/${dueDate.year}"),
                        const SizedBox(width:10),
                        Container(
                          height: 40,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF307473)),
                          child: IconButton(
                            onPressed: () async{
                              DateTime? currentValue;
                              currentValue = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: Color(0xFF000030), // <-- SEE HERE
                                        onPrimary: Colors.white, // <-- SEE HERE
                                        onSurface: Colors.black, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: const Color(0xFF000030), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              dueDate = currentValue!;
                              setState((){});
                            },
                            icon: const Icon(Icons.calendar_month_outlined, color: Colors.white,)
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(onPressed: (){
                if(title != "") {
                  trello_card newTask = trello_card();
                  newTask.dueDate = dueDate.toString();
                  newTask.title = title;
                  newTask.members = members;
                  newTask.list = widget.lists[0];
                  newTask.createdDate = Timestamp.fromDate(DateTime.now());
                  newTask.board = widget.name;
                  newTask.setRefreshBoard(refresh);
                  _tasks.add(newTask);
                  refresh();
                  Navigator.of(context).pop();
                  FirebaseFirestore.instance.collection('tasks').add(newTask.toJson());
                } else{
                }
                },
                  child: const Text("Add", style: TextStyle(color: Color(0xFF000030)),)),
              TextButton(onPressed: (){Navigator.of(context).pop();},
                  child: const Text("Close", style: TextStyle(color: Color(0xFF000030)),)),
            ],
          );
        }
      );
    }
    );
  }

}