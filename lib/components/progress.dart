import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Progress extends StatelessWidget {
  final String message;
  const Progress({super.key, this.message='Loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/json/Animation_1723745275824.json',
            alignment: Alignment.center,
            width: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ],
      ),
    );
  }
}