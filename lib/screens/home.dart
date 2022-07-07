import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'board.dart';

class home extends StatefulWidget{

  home ({ Key? key}): super(key: key);

  _home createState() => _home();
}

class _home extends State<home>{
  List<trello_board> _boards = [];


  @override
  Widget build(BuildContext context) {
    getBoardsFromFB();

    return Scaffold(
      appBar: AppBar(
        title: const Text("EWP Organization"),
      ),
      body: Column(
        children: [
          //Text("but this works wtf"),
          ListView.separated(
              itemCount: _boards.length,
              shrinkWrap: true,
              itemBuilder: (context, int index){
                return ListTile(
                  title: Text(_boards[index].name),
                  onTap: ((){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  _boards[index]),
                    );
                  }),
                );
              },
              separatorBuilder: (context, index){
                return Divider();
              },
          )
        ],
      ),
    );
  }

  Future getBoardsFromFB() async{
    var data = await FirebaseFirestore.instance.collection('boards').get();
    _boards = List.from(data.docs.map((doc) => trello_board.fromSnapshot(doc)));
  }

}