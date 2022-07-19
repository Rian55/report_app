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
  void initState() {
    getBoardsFromFB();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFDEDEDE),
      appBar: AppBar(
        backgroundColor: Color(0xFF000030),
        title: const Text("EWP Organization"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 21),
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
    if(_boards.length < 1) {
      var data = await FirebaseFirestore.instance.collection('boards').get();
      _boards = List.from(data.docs.map((doc) => trello_board.fromSnapshot(doc)));
    }
  }

}