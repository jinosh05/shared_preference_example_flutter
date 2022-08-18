import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyShared(),
  ));
}

class MyShared extends StatefulWidget {
  MyShared({Key? key}) : super(key: key);

  @override
  _MySharedState createState() => _MySharedState();
}

class _MySharedState extends State<MyShared> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2E0249),
        title: Text("Shared Preferences"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
