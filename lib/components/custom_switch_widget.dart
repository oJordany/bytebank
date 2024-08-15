import 'package:bytebank/components/app_controller.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget{
  CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
    });
  }
}