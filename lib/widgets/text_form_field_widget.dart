import 'package:flutter/material.dart';

InputDecoration decoration(String label) {
  return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
}

String? requiredValidator(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return "Por favor, insira $fieldName";
  }
  return null;
}

String? requiredEmailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "Por favor, insira um email";
  }
  //validação de email
  String pattern =
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Por favor, insira um email válido';
  }
  return null;
}
