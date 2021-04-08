import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      toolbarHeight: 50,
      title: const Text(
        "OLX парсер - 1.0.0",
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, "contact"),
        ),
        IconButton(
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pushNamed(context, "warning_info"),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(60, 50);
}
