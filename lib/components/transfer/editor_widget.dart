import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final String _tip;
  final IconData? _icon;

  const Editor(
      {super.key,
      required TextEditingController controller,
      required String label,
      required String tip,
      IconData? icon})
      : _controller = controller,
        _label = label,
        _tip = tip,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: _icon != null ? Icon(_icon) : null,
          labelText: _label,
          hintText: _tip,
        ),
      ),
    );
  }
}