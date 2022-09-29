import 'package:flutter/material.dart';
// import 'package:inspection_app/helper.dart';
// import '../data.dart' show Building;
// import 'package:flutter_form_builder/flutter_form_builder.dart';

class ListWindows extends StatefulWidget {
  const ListWindows({super.key});

  @override
  ListWindowsState createState() {
    return ListWindowsState();
  }
}

class ListWindowsState extends State<ListWindows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fenster bearbeiten'),
        ),
        body: const Text('Hello, world!'));
  }
}
