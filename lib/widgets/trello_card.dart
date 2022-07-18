import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class trello_card extends StatefulWidget{
  String board = "";
  String title = "";
  List<dynamic> members = [];
  String dueDate = "";
  Timestamp? createdDate;
  String list = "";
  String id = "";

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
}

class _trello_card extends State<trello_card>{

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Container(
      height: 210,
      width: 310,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21.0)),
        color: Colors.white,
        elevation: 2.0,
        child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 6,),
                cardField("Stage: ", widget.list),
                cardField("Members: ", membersToStr()),
                //cardField("Last Activity: ", widget.createdDate.toString()),
                //cardField("Due Date: ", widget.dueDate.toString()),
                Checkbox(
                  checkColor: Colors.black,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              ]
            ),
          )
      ),
    );
  }
  String membersToStr(){
    String rtrn = "";
    for(int i = 0; i < widget.members.length; i++) {
      rtrn += widget.members[i];
      if(i != widget.members.length-1) {
        rtrn += ", ";
      }
    }
    return rtrn;
  }

  Widget cardField(String bldPart, String filler){
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: bldPart, style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: filler),
        ],
      ),
    );
  }

}