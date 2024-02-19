import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const MyAlertBox({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      title: const Text(
        "Enter habit name",
        style: TextStyle(color: Color.fromRGBO(55, 71, 79, 1) ,fontWeight: FontWeight.bold),
      ),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            controller: controller,
            validator: (value) {
              if (value == null) {
                return "Enter a VALID Habit";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "Enter a habit...",
              hintStyle: TextStyle(color: Colors.black26),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black45),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: -109,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          //style: TextButton.styleFrom(
          //  backgroundColor:
          // const Color.fromARGB(255, 9, 217, 36),
          //  ),
          child: const Text(
            "Save",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
