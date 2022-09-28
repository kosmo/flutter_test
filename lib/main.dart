import 'package:flutter/material.dart';
import 'widgets/buildings.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Seecon Gebäudeerfassung';

    return MaterialApp(
      title: appTitle,
      initialRoute: "/",
      routes: {
        '/': (context) => const ListBuildings(),
      },
    );
  }
}
