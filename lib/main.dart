import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preference_example/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  var outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffA91079),
    ),
  );
  runApp(
    MaterialApp(
      home: const MyShared(),
      theme: ThemeData(
        brightness: Brightness.dark,
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xffF806CC),
          side: const BorderSide(
            color: Color(0xffA91079),
          ),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xff2E0249),
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
  const MyShared({Key? key}) : super(key: key);

  @override
  MySharedState createState() => MySharedState();
}

class MySharedState extends State<MyShared> {
  late List<TextEditingController> _controllers;
  bool _boolVal = true;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      9,
      (index) => TextEditingController(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double inputWidth = width * 0.4;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffA91079),
        title: const Text("Shared Preferences"),
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
                    _storeValue(Keys.stringKey, _controllers[0].text);
                    _controllers[0].clear();
                  },
                  child: const Text('Save String')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[0],
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    _controllers[0].text = await _getValue(Keys.stringKey);
                    setState(() {});
                  },
                  child: const Text('Show String')),
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
                    _storeValue(Keys.intKey, _controllers[1].text);
                    _controllers[1].clear();
                  },
                  child: const Text('Save Integer')),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  controller: _controllers[1],
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              OutlinedButton(
                  onPressed: () async {
                    _controllers[1].text = await _getValue(Keys.intKey);
                    setState(() {});
                  },
                  child: const Text('Show Integer')),
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
                    _storeValue(Keys.doubleKey, _controllers[2].text);
                    _controllers[2].clear();
                  },
                  child: const Text('Save Double')),
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
                    _controllers[2].text = await _getValue(Keys.doubleKey);
                    setState(() {});
                  },
                  child: const Text('Show Double')),
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
                    _storeValue(Keys.boolKey, _boolVal);
                    setState(() {
                      _boolVal = false;
                    });
                  },
                  child: const Text('Save Bool')),
              SizedBox(
                  width: inputWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                        fillColor: MaterialStateProperty.all(Colors.white),
                        checkColor: const Color(0xff2E0249),
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
                    _boolVal = await _getValue(Keys.boolKey);
                    setState(() {});
                  },
                  child: const Text('Show Bool')),
            ],
          ),

          //
          // List of String
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (var i = 0; i < 4; i++)
                SizedBox(
                  width: inputWidth / 2,
                  child: TextField(
                    controller: _controllers[i + 5],
                  ),
                ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    List<String> strList = [];
                    for (var i = 0; i < 4; i++) {
                      strList.add(_controllers[i + 5].text);
                      _controllers[i + 5].clear();
                    }
                    _storeValue(Keys.strListKey, strList);
                  },
                  child: const Text('Save List')),
              ElevatedButton(
                  onPressed: () async {
                    List<String> strList = await _getValue(Keys.strListKey);

                    for (var i = 0; i < 4; i++) {
                      _controllers[i + 5].text = strList[i];
                    }
                    setState(() {});
                  },
                  child: const Text('Show List')),
            ],
          ),
        ],
      ),
    );
  }

  void _storeValue(String variable, data) async {
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

  _getValue(data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic a;
    a = pref.get(data);
    print(a);
    return a;
  }
}
