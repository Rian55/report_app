import 'package:flutter/material.dart';

import 'Task.dart';

class MainPage extends StatefulWidget {
  final List<Task> tasks;

  const MainPage({ Key? key, required this.tasks}): super(key: key);
  @override
  _MainPage createState() => _MainPage();

}

class _MainPage extends State<MainPage> {
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Tümü", child: Text("Tümü")),
      const DropdownMenuItem(value: "Yapılması Gerekenler", child: Text("Yapılması Gerekenler")),
      const DropdownMenuItem(value: "Başladım", child: Text("Başladım")),
      const DropdownMenuItem(value: "Kontrol Edilmeli", child: Text("Kontrol Edilmeli")),
      const DropdownMenuItem(value: "Bitti", child: Text("Bitti")),
      const DropdownMenuItem(value: "Düzeltilecek", child: Text("Düzeltilecek")),
      const DropdownMenuItem(value: "Sabit Görevler", child: Text("Sabit Görevler")),
      const DropdownMenuItem(value: "Her Cuma/Hafta", child: Text("Her Cuma/Hafta")),
      const DropdownMenuItem(value: "Her Ay", child: Text("Her Ay")),
    ];

    return menuItems;
  }
  String selectedValue = "Tümü";


    @override
    Widget build(BuildContext context) {
      return Container(
        child: Column(
            children: [
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
                    ]
                ),
              ),

              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 13),
                  Container(
                    color: Colors.white,
                    width: 200,
                    height: 60,
                    child: InputDecorator(
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          menuMaxHeight: 300,
                          value: selectedValue,
                          items: dropdownItems,
                          onChanged: (String? choice){
                            setState(() {
                              selectedValue = choice!;
                            });
                            getRndBtn("text");
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              widget.tasks[0],
            ],
        ),
      );
    }


// method responsible of changing the text

  Widget getRndBtn(String text){
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(40, 40),
        shape: const CircleBorder(),
        primary: Colors.black54,
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


}