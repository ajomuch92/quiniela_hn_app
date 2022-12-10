import 'package:flutter/material.dart';

class FieldDefinition {
  String name;
  String? label, helperText, requiredMessage = 'Este campo es requerido', initialValue;
  bool? required = true, obscureText = false;
  Widget? suffix;
  TextEditingController controller = TextEditingController();
  TextInputType textInputType = TextInputType.text;
  TextInputAction textInputAction = TextInputAction.done;

  FieldDefinition({
    required this.name, 
    this.label,
    this.helperText,
    this.required,
    this.obscureText,
    this.requiredMessage,
    this.suffix,
    this.initialValue,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done}){
    controller.text = initialValue ?? '';
  }

  String get value => controller.text;

  bool isValid() {
    bool isRequired = required ?? false;
    if ((isRequired && controller.text.isNotEmpty) || !isRequired) {
      return true;
    }
    return false;
  }
}