import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_example/keys.dart';
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
  bool _boolVal = true;

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
          //
          // String Row
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    storeMyData(Keys.stringKey, _controllers[0].text);
                    _controllers[0].clear();
                  },
                  child: Text('Save String')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[0],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    _controllers[0].text = await showData(Keys.stringKey);
                    setState(() {});
                  },
                  child: Text('Show String')),
            ],
          ),

          //
          // int Row
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    storeMyData(Keys.intKey, _controllers[1].text);
                    _controllers[1].clear();
                  },
                  child: Text('Save Integer')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[1],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              OutlinedButton(
                  onPressed: () async {
                    _controllers[1].text = await showData(Keys.intKey);
                    setState(() {});
                  },
                  child: Text('Show Integer')),
            ],
          ),

          //
          // double Row
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    storeMyData(Keys.doubleKey, _controllers[2].text);
                    _controllers[2].clear();
                  },
                  child: Text('Save Double')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[2],
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    _controllers[2].text = await showData(Keys.doubleKey);
                    setState(() {});
                  },
                  child: Text('Show Double')),
            ],
          ),

          //
          // bool Row
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    storeMyData(Keys.boolKey, _boolVal);
                    setState(() {
                      _boolVal = false;
                    });
                  },
                  child: Text('Save Bool')),
              SizedBox(
                  width: inputWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        checkColor: Color(0xff2E0249),
                        value: _boolVal,
                        onChanged: (value) {
                          setState(() {
                            _boolVal = value ?? false;
                          });
                        },
                      ),
                      Text(_boolVal ? "It's true " : "It's false")
                    ],
                  )),
              OutlinedButton(
                  onPressed: () async {
                    _boolVal = await showData(Keys.boolKey);
                    setState(() {});
                  },
                  child: Text('Show Bool')),
            ],
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

  showData(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic a;
    a = pref.get(data);
    print(a);
    return a;
  }
}
