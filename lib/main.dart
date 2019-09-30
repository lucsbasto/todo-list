import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO-LIST ToPeRsOn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = List<Item>();

  HomePage() {
    items.add(Item(title: "Item 1", done: false));
    items.add(Item(title: "Item 2", done: false));
    items.add(Item(title: "Item 3", done: false));
    items.add(Item(title: "Item 4", done: false));
    items.add(Item(title: "Item 5", done: false));
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();
  void add() {
    if (newTaskCtrl.text.isEmpty) return;
    setState(() {
      widget.items.add(
        Item(
          title: newTaskCtrl.text,
          done: false,
        ),
      );
    });

    newTaskCtrl.clear();
  }

  void remove(Item item) {
    setState(() {
      widget.items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: TextFormField(
          focusNode: FocusNode(),
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: "Novo Item",
            labelStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            var item = widget.items[index];
            return Dismissible(
              child: CheckboxListTile(
                activeColor: Colors.indigoAccent,
                title: new Text(item.title.toUpperCase(),
                    style: new TextStyle(
                      color: item.done
                          ? Colors.indigo.withOpacity(0.5)
                          : Colors.black,
                    )),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                  });
                },
              ),
              key: Key(item.title),
              background: Container(
                color: Colors.blueGrey.withOpacity(0.1),
              ),
              onDismissed: (direction) {
                remove(item);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          add();
        },
        child: Icon(Icons.add_box),
        backgroundColor: Colors.indigo.withOpacity(0.9),
      ),
    );
  }
}
