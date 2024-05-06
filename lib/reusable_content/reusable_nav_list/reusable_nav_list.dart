import 'package:blood_transfusion_register/constants/constants.dart';
import 'package:flutter/material.dart';

class NavIconContent extends StatelessWidget {
  const NavIconContent(this.iconData, this.label, this.onTap, {super.key});

  final IconData iconData;
  final String label;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(iconData),
          const SizedBox(
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
