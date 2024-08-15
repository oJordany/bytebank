import 'package:bytebank/screens/contact/list_page.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const FeatureItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onClick,
  }): assert(icon != null),
      assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            // GestureDetector do próprio Material
            onTap: () => onClick(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    size: 24.0,
                    icon,
                    color: Colors.white,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
