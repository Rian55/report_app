import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Task.dart';



class MainPage extends StatefulWidget {
  String stage = "Tümü";
  String member = "";
  List<Task> allTasks = [];
  List<Widget> sortedTasks = [];

  MainPage({ Key? key}): super(key: key);
  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Tümü", child: Text("Tümü")),
      const DropdownMenuItem(
          value: "Yapılması Gerekenler", child: Text("Yapılması Gerekenler")),
      const DropdownMenuItem(value: "Başladım", child: Text("Başladım")),
      const DropdownMenuItem(
          value: "Kontrol Edilmeli", child: Text("Kontrol Edilmeli")),
      const DropdownMenuItem(value: "Bitti", child: Text("Bitti")),
      const DropdownMenuItem(
          value: "Düzeltilecek", child: Text("Düzeltilecek")),
      const DropdownMenuItem(
          value: "SABİT GÖREVLER", child: Text("Sabit Görevler")),
      const DropdownMenuItem(
          value: "Her Cuma/Hafta", child: Text("Her Cuma/Hafta")),
      const DropdownMenuItem(value: "Her Ay", child: Text("Her Ay")),
    ];

    return menuItems;
  }

  String selectedValue = "Tümü";


  @override
  Widget build(BuildContext context) {
    //<-----------------------------------IT'S HERE
    letsTryAgain(context);
    widget.sortedTasks.removeRange(0, widget.sortedTasks.length);
    for (int i = 0; i < widget.allTasks.length; i++) {
      if (widget.allTasks[i].stage.contains(widget.stage) &&
          !widget.stage.contains("Tümü") &&
          widget.allTasks[i].members.contains(widget.member)) {
        widget.sortedTasks.add(widget.allTasks[i]);
      } else if (widget.stage.contains("Tümü") &&
          widget.allTasks[i].members.contains(widget.member)) {
        widget.sortedTasks.add(widget.allTasks[i]);
      } else if (widget.member == "" &&
          widget.allTasks[i].stage.contains(widget.stage)) {
        widget.sortedTasks.add(widget.allTasks[i]);
      } else if (widget.member == "" && widget.stage.contains("Tümü")) {
        widget.sortedTasks.add(widget.allTasks[i]);
      }
    }

    return Column(
      children: [
        Material(
          elevation: 8,
          color: Color(0xfff0f0e2),
          child: Column(
            children: [
              SizedBox(height: 50),
              SizedBox(
                height: 80.0,
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 5,),
                      getRndBtn("SR"),
                      const SizedBox(width: 5,),
                      getRndBtn("RR"),
                      const SizedBox(width: 5,),
                      getRndBtn("SK"),
                      const SizedBox(width: 5,),
                      getRndBtn("SS"),
                      const SizedBox(width: 5,),
                      getRndBtn("EK"),
                      const SizedBox(width: 5,),
                      getRndBtn("Y"),
                      const SizedBox(width: 5,),
                      getRndBtn("BG"),
                      const SizedBox(width: 5,),
                      getRndBtn("DS"),
                      const SizedBox(width: 5,),
                    ]
                ),
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(width: 13),
                  Container(
                    color: Color(0xfff0f0e2),
                    width: 200,
                    height: 60,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21.0)),
                        fillColor: Color(0xfff0f0e2),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          menuMaxHeight: 350,
                          value: selectedValue,
                          items: dropdownItems,
                          onChanged: (String? choice) {
                            setState(() {
                              selectedValue = choice!;
                              widget.stage = selectedValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        printCards(),
      ],
    );
  }

  Widget printCards() {
    if (widget.sortedTasks.length == 0) {
      return Column(
        children: const [
          SizedBox(height: 15),
          Text(
            "No tasks at this stage currently",
            style: TextStyle(fontSize: 18),
          ),
        ],
      );
    }
    return Expanded(child: ListView.builder(

        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.sortedTasks.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.sortedTasks[index];
        }
    )
    );
  }

  Widget getRndBtn(String text) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          if (text == "SR") {
            if (widget.member != "stella ryzhova")
              widget.member = "stella ryzhova";
            else
              widget.member = "";
          } else if (text == "RR") {
            if (widget.member != "Rian Ryzhov")
              widget.member = "Rian Ryzhov";
            else
              widget.member = "";
          } else if (text == "SS") {
            if (widget.member != "Selin Selbastı")
              widget.member = "Selin Selbastı";
            else
              widget.member = "";
          } else if (text == "SK") {
            if (widget.member != "Sinem Kanat")
              widget.member = "Sinem Kanat";
            else
              widget.member = "";
          } else if (text == "Y") {
            if (widget.member != "Yahya")
              widget.member = "Yahya";
            else
              widget.member = "";
          } else if (text == "DS") {
            if (widget.member != "Damla Saim")
              widget.member = "Damla Saim";
            else
              widget.member = "";
          } else if (text == "EK") {
            if (widget.member != "Elham kokabi")
              widget.member = "Elham kokabi";
            else
              widget.member = "";
          } else if (text == "BG") {
            if (widget.member != "Beyza Güller")
              widget.member = "Beyza Güller";
            else
              widget.member = "";
          }
        });
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(40, 40),
        shape: const CircleBorder(),
        primary: Color(0xFF861BFD),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
    );
  }

  Future letsTryAgain(BuildContext context) async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection(
        'tasks');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    widget.allTasks.removeRange(0, widget.allTasks.length);

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<String> strs = [];
    for (var x in allData)
      strs.add(x.toString());

    final re = RegExp(r'([,{}\[\]:])+');

    for (int index = 0; index < strs.length; index++) {
      List<String> splitted = strs[index].split(re);
      String title = "";
      List<String> members = [];
      String dueDate = "";
      String lastActivity = "";
      String stage = "";

      for (int i = 0; i < splitted.length; i++) {
        if (splitted[i].contains("dueDate")) {
          dueDate = splitted[i + 1];
          i++;
        } else if (splitted[i].contains("Title")) {
          title = splitted[i + 1];
          i++;
        } else if (splitted[i].contains("Stage")) {
          stage = splitted[i + 1];
          i++;
        } else if (splitted[i].contains("lastActivity")) {
          lastActivity = splitted[i + 1];
          i++;
        } else if (splitted[i].contains("Members")) {
          for (int j = 1; j + i < splitted.length; j++) {
            members.add(splitted[i + j]);
          }
        }
      }
      widget.allTasks.add(Task(
        dueDate: dueDate,
        lastActivity: lastActivity,
        stage: stage,
        members: members,
        title: title,
      ));
    }
  }
}