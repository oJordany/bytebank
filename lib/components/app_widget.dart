import 'package:bytebank/components/app_controller.dart';
import 'package:bytebank/screens/home_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor:
                      WidgetStatePropertyAll(Colors.blueAccent[700]),
                  foregroundColor: WidgetStatePropertyAll(Colors.blue[900]),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blueAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                foregroundColor: Colors.blueAccent[900],
              ),
              appBarTheme: AppBarTheme(
                  color: Colors.green[900],
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  )),
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light,
              primaryColor: Colors.green[900],
            ),
            home: HomePage(),
          );
        });
  }
}
