import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get documentsPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

class Building {
  static Future<Map> buildings() async {
    String path = await documentsPath;
    var data = {};

    // Prüfung ob es bereits eine json-Datei, mit manipulierrten Daten, im Documents-Ordner gibt.
    // Wenn nicht die Standardvariante ausliefern.
    if (await File('$path/buildings.json').exists()) {
      data = json.decode(await rootBundle.loadString('$path/buildings.json'));
    } else {
      data = json.decode(await rootBundle.loadString('lib/buildings.json'));
    }

    return data;
  }

  static Future<List> buildingsList() async {
    // Todo: Dies geht vielleicht noch eleganter mit Klassenvariable?
    final Map buildings = await Building.buildings();
    List buildingsList = [];

    buildings.forEach((key, value) {
      // id vom key der Map in den List-Eintrag verschieben
      var valueMergedWithId = {
        ...value,
        ...{"id": key}
      };

      buildingsList.add(valueMergedWithId);
    });

    return buildingsList;
  }

  static Future editBuilding(id, building) async {
    Map buildings = await Building.buildings();
    if (building.containsKey("id")) {
      building.remove("id");
    }

    buildings[id] = building;

    String path = await documentsPath;
    File('$path/buildings.json').writeAsString(json.encode(buildings));
  }

  Future modify(building) async {}
}
