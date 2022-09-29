import 'package:flutter/material.dart';
import 'widgets/buildings.dart';
import 'package:camera/camera.dart';

var firstCamera;

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  firstCamera = cameras.first;

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
