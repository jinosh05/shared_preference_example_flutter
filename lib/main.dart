import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  var outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffA91079),
    ),
  );
  runApp(
    MaterialApp(
      home: MyShared(),
      theme: ThemeData(
        brightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          primary: Color(0xffF806CC),
          side: BorderSide(
            color: Color(0xffA91079),
          ),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          primary: Color(0xffA91079),
        )),
        inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder),
      ),
    ),
  );
}

class MyShared extends StatefulWidget {
  MyShared({Key? key}) : super(key: key);

  @override
  _MySharedState createState() => _MySharedState();
}

class _MySharedState extends State<MyShared> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double inputWidth = width * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2E0249),
        title: Text("Shared Preferences"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: () {}, child: Text('Save String')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[0],
                ),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Show String')),
            ],
          ),
          TextButton(
              onPressed: () {
                storeMyData("str", "My String");
              },
              child: Text("Save String")),
          OutlinedButton(
            onPressed: () {
              showData("str");
            },
            child: Text(" Show value"),
          ),
          TextButton(
              onPressed: () {
                storeMyData("int", 25);
              },
              child: Text("Save Integer")),
          ElevatedButton(
            onPressed: () {
              showData("int");
            },
            child: Text(" Show value"),
          ),
          TextButton(
              onPressed: () {
                storeMyData("double", 99.99);
              },
              child: Text("Save Double")),
          MaterialButton(
            onPressed: () {
              showData("double");
            },
            child: Text(" Show value"),
          ),
          TextButton(
              onPressed: () {
                storeMyData("bool", true);
              },
              child: Text("Save Bool")),
          RawMaterialButton(
            onPressed: () {
              showData("bool");
            },
            child: Text(" Show value"),
          ),
          TextButton(
              onPressed: () {
                storeMyData("listStr", ["A", "B", "C"]);
              },
              child: Text("Save List")),
          CupertinoButton(
            onPressed: () {
              showData("int");
            },
            child: Text(" Show value"),
          )
        ],
      ),
    );
  }

  void storeMyData(String variable, data) async {
    var pref = await SharedPreferences.getInstance();
    if (data is bool) {
      pref.setBool(variable, data);
    }
    if (data is int) {
      pref.setInt(variable, data);
    }
    if (data is double) {
      pref.setDouble(variable, data);
    }
    if (data is String) {
      pref.setString(variable, data);
    }
    if (data is List<String>) {
      pref.setStringList(variable, data);
    }
    print("Saved $data in  $variable");
  }

  void showData(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic a;
    a = pref.get(data);
    print(a);
  }
}
