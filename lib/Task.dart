import 'package:flutter/material.dart';

class Task extends StatefulWidget{
  final String title;
  final List<String> members;
  final String dueDate;
  final String lastActivity;
  final String stage;

  const Task ({ Key? key, required this.title, required this.members,
    required this.dueDate, required this.lastActivity, required this.stage }): super(key: key);


  @override
  _Task createState() => _Task();

}

class _Task extends State<Task>{

  @override
  Widget build(BuildContext context) {
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
                cardField("Stage: ", widget.stage),
                cardField("Members: ", membersToStr()),
                cardField("Last Activity: ", widget.lastActivity),
                cardField("Due Date: ", widget.dueDate),
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