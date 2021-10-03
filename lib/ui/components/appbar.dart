import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:olx_parser/ui/screens/contact_screen.dart';

class ParserAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      toolbarHeight: 50,
      title: const Text(
        "OLX парсер | 1",
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () => Get.to(ContactScreen()),
          icon: const Icon(
            Icons.phone,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(60, 50);
}
