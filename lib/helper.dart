import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

List<Widget> textFieldsFromMap(map) {
  List<Widget> textFields = [];
  map.forEach((key, value) {
    textFields.add(FormBuilderTextField(
      name: key.toString(),
      initialValue: value.toString(),
      decoration: InputDecoration(
        labelText: key.toString(),
      ),
    ));
  });

  return textFields;
}
