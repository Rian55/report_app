import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:report_app/widgets/member_list.dart';

class trello_card extends StatefulWidget{
  String board = "";
  String title = "";
  List<dynamic> members = [];
  String? dueDate;
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
    //removed = snapshot['Removed'];
    id = snapshot.id;
  }

  Map<String, dynamic> toJson() =>
      {
        'Board': board,
        'Title': title,
        'Members': members,
        'dueDate': dueDate,
        'createdDate': createdDate,
        'List': list,
        'Removed': removed,
      };

  void setRefreshBoard(Function() refresh) {
    _refreshBoard = refresh;
  }
}

class _trello_card extends State<trello_card>{
  double _height = 190;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: GestureDetector(
        onTap: (){
          showCard(context);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.white,
          elevation: 2.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  width: 160,
                  decoration: const BoxDecoration(
                      color: Color(0xFF307473),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Text(widget.list, style: const TextStyle(color: Colors.white,
                      fontSize: 13, fontFamily: "Monsterrat"),),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  height: 38,
                  child: SingleChildScrollView(
                    child: Text(
                      getTitle(),
                      style: const TextStyle(fontSize: 15, color: Color(0xFF000025), fontFamily: "Monsterrat"),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width-76,
                        child: member_list(function: null, SIZE: 20, members: widget.members),
                    ),
                      IconButton(
                        onPressed: (){showAlertDialog(context);},
                        icon: Icon(Icons.delete, color: Color(0xFFDEDEDE),),
                      ),
                    ]
                )

              ]
            )
          )
        ),
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
        widget._refreshBoard!();
        Navigator.of(context).pop();
        FirebaseFirestore.instance.collection('tasks').doc(widget.id).update({'Removed': widget.removed});
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

  showCard(BuildContext context){
    Widget closeButton = TextButton(
      child: const Text("Close"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog card = AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        height: 280,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              width: 160,
              decoration: const BoxDecoration(
                  color: Color(0xFF307473),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Text(widget.list, style: const TextStyle(color: Colors.white,
                  fontSize: 13, fontFamily: "Monsterrat"),),
            ),
            SizedBox(height: 10,),
            Text("Members:  "),
            SizedBox(height: 10,),
            SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width-76,
                child: member_list(function: null, members: widget.members, SIZE: 20)
            ),
            SizedBox(height: 10,),
            //Text("Due Date: ${widget.dueDate}"),
            SizedBox(height: 10,),
            Text("Created Date: ${widget.createdDate!.toDate().day}/"
                "${widget.createdDate!.toDate().month}/${widget.createdDate!.toDate().year}"),
          ],
        ),
      ),
      actions: [
        closeButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return card;
      },
    );
  }

  String getTitle(){
    List<String> words = widget.title.split(" ");
    String rtrn = words[0];
    for(int i = 1; i < 9; i++){
      if(i >= words.length)
        break;
      rtrn += " ${words[i]}";
    }
    if(words.length > 9)
      rtrn += "...";
    return rtrn;
  }
}