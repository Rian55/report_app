import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:report_app/widgets/member_list.dart';

class trello_card extends StatefulWidget{
  String board = "";
  String title = "";
  List<dynamic> members = [];
  String dueDate = "";
  Timestamp? createdDate;
  String list = "";
  String id = "";
  bool removed = false;
  Function()? _refreshBoard;

  trello_card ({ Key? key}): super(key: key);


  @override
  _trello_card createState() => _trello_card();

  trello_card.fromSnapshot(DocumentSnapshot snapshot){
    title = snapshot['Title'];
    members = snapshot['Members'];
    dueDate = snapshot['dueDate'].toString();
    createdDate = snapshot['createdDate'];
    list = snapshot['List'];
    board = snapshot['Board'];
    id = snapshot.id;
  }

  void setRefreshBoard(Function() refresh) {
    _refreshBoard = refresh;
  }
}

class _trello_card extends State<trello_card>{
  double _height = 180;

  @override
  void initState() {
    //_set_heigth();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 142,
                      decoration: const BoxDecoration(
                          color: Color(0xFF307473),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: Text(widget.list, style: const TextStyle(color: Colors.white,
                          fontSize: 13, fontFamily: "Monsterrat"),),
                    ),
                    SizedBox(height: _height-110,),
                    Row(
                      children: [Container(
                        alignment: Alignment.bottomLeft,
                        height: 40,
                        width: 160,
                        child: member_list(function: null, SIZE: 20, members: widget.members),
                      ),
                      ]
                    )
                    //
                  ]
                ),
              const SizedBox(width: 18),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      child: SingleChildScrollView(
                        child: Text(
                          widget.title,
                          style: const TextStyle(fontSize: 15, color: Color(0xFF000025), fontFamily: "Monsterrat"),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(height: 47),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: (){showAlertDialog(context);},
                          icon: Icon(Icons.delete, color: Color(0xFFDEDEDE),),
                      ),
                    ]
                    )
                  ],
                ),
              ),
              const SizedBox(width: 30),

            ]
          )
        )
      )
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    Widget deleteButton = TextButton(
      child: const Text("Delete", style: TextStyle(color: Colors.red),),
      onPressed:  () {
        widget.removed = true;
        widget._refreshBoard;
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Card"),
      content: const Text("By pressing Delete you agree to remove this card to archieve"),
      actions: [
        deleteButton,
        cancelButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*void _set_heigth(){
    if (widget.title.length > 33){
      _height +=  ((widget.title.length - 33)/11)*8;
    }
  }*/
}