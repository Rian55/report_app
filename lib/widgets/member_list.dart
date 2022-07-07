import 'package:flutter/material.dart';

class member_list extends StatefulWidget{
  final List<String> members;
  const member_list ({ Key? key, required this.members}): super(key: key);
  
  @override
  _member_list createState() => _member_list();
  
  
}

class _member_list extends State<member_list>{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.separated(
        itemCount: widget.members.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){

          return ElevatedButton(
            onPressed: () {
              setState(() {


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
    );
  }
  
  String get_initials(int index){
    final re = RegExp(r'^.');
    
    return '';
  }
}