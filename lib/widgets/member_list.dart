import 'package:flutter/material.dart';

class member_list extends StatefulWidget{
  final List<dynamic> members;
  final Function(String)? function;
  final double SIZE;
  const member_list({super.key, required this.function, required this.members, required this.SIZE});

  @override
  _member_list createState() => _member_list();

}

class _member_list extends State<member_list>{

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.members.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return ElevatedButton(
          onPressed: () {
            if(widget.function != null) {
              widget.function!(widget.members[index]);
            }
          },
          style: ElevatedButton.styleFrom(
            fixedSize: Size(widget.SIZE, widget.SIZE),
            shape: const CircleBorder(),
            primary: const Color(0xFF519872),
          ),
          child: Text(
            get_initials(widget.members[index]),
            style: TextStyle(
              fontSize: widget.SIZE/1.7,
              color: Colors.white,
            ),
          ),
        );
      },
      separatorBuilder: (context, index){
        return const SizedBox(width: 5,);
      },
    );
  }

  String get_initials(String member){
    final re = RegExp(r'^.');
    String rtrn = "";
    List<String?> fullName = ["0"];
    fullName = member.split(" ");
    for(int i = 0; i < fullName.length; i++){
      rtrn += re.stringMatch(fullName[i]!)!;
    }
    return rtrn;
  }
}