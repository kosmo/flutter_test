import 'package:flutter/material.dart';
import 'package:inspection_app/helper.dart';
import 'package:inspection_app/widgets/windows.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../data.dart' show Building;
import '../camera.dart';
import '../main.dart';

// Gebäudeliste
class ListBuildings extends StatefulWidget {
  const ListBuildings({super.key});

  @override
  ListBuildingsState createState() {
    return ListBuildingsState();
  }
}

class ListBuildingsState extends State<ListBuildings> {
  @override
  Widget build(BuildContext context) {
    //_title = widget._title; // <<< ADDING THIS HERE IS THE FIX
    return FutureBuilder(
        future: Building.buildingsList(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Gebäude"),
                  ),
                  body: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          child: Container(
                            //onPressed:
                            height: 50,
                            color: (index % 2 == 0)
                                ? Colors.amber[300]
                                : Colors.amber[100],
                            child: Center(
                                child: Text(snapshot.data![index]["name"])),
                          ),
                          onTap: () {
                            //Navigator.push( context, MaterialPageRoute( builder: (context) => SecondPage()), ).then((value) => setState(() {}));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditBuilding(snapshot.data![index]),
                              ),
                              // setState sorgt dafür, dass das ListBuildings-Widget nach EditBuilding neu gerendert wird und so
                              // die Veränderungen auch dargestellt werden.
                            ).then((value) => setState(() {}));
                          });
                    },
                  ),
                );
              } else {
                return const Center(
                  child: Text('Error Error'),
                );
              }
          }
        });
  }
}

class EditBuilding extends StatefulWidget {
  final Map building;
  const EditBuilding(this.building, {super.key});
  // const EditBuilding({super.key});
  //static const routeName = '/EditBuilding';

  @override
  EditBuildingState createState() {
    return EditBuildingState();
  }
}

class EditBuildingState extends State<EditBuilding> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gebäude "${widget.building["name"]}" bearbeiten'),
        ),
        body: FormBuilder(
          key: _formKey,
          child: Column(
            children: (textFieldsFromMap(widget.building) +
                [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        // Merge existing json building (with id and maybe other uneditable fields) with the edited form values
                        var mergedBuildingMap = {
                          ...widget.building,
                          ..._formKey.currentState!.instantValue
                        };
                        mergedBuildingMap;
                        Building.editBuilding(
                            widget.building["id"], mergedBuildingMap);
                      }
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListWindows(),
                        ),
                      );
                    },
                    child: const Text('ListWindows'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TakePictureScreen(
                            camera: firstCamera,
                          ),
                        ),
                      );
                    },
                    child: const Text('ListWindows'),
                  ),
                ]),
          ),
        ));
  }
}
