// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';

import 'zen_zone.dart';

class AnonymousChat extends StatefulWidget {
  const AnonymousChat({Key? key}) : super(key: key);

  @override
  _AnonymousChatState createState() => _AnonymousChatState();
}

class _AnonymousChatState extends State<AnonymousChat> {
  TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var uuid = const Uuid();
  bool isAnimationPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('Search Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.scale(
              scale: 1.3,
              child: Lottie.asset(
                'assets/LottieAssets/groupchat_animate.json',

                repeat: isAnimationPlaying
                    ? true
                    : false, // Control animation repetition
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(38, 50, 56, 0.87),
                ),
                onPressed: () {
                  // Stop playing the animation when the button is pressed
                  //  setState(() {
                  //   isAnimationPlaying = false;
                  //   });

                  showDialog(
                    context: context,
                    builder: (BuildContext content) => AlertDialog(
                      backgroundColor: Colors.white.withOpacity(0.89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      title: const Text(
                        "Enter Anonymous Name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      content: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Form(
                            key: formKey,
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.length < 3) {
                                  return "Enter a VALID NAME";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Discreet name...",
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
                          ),
                          const Positioned(
                            left: 0,
                            right: 0,
                            bottom: -130,
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
                        Text(
                          "Unlock functionality on our web.app",
                          style: TextStyle(
                              color:
                                  Colors.grey[500]), // Light shade text color
                        ),
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              String name = nameController.text;
                              nameController.clear();
                              //Navigator.pushReplacement(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ZenZone(
                                    name: name,
                                    userId: uuid.v1(),
                                  ),
                                ),
                              );
                            }
                          },
                          //style: TextButton.styleFrom(
                          //  backgroundColor:
                          // const Color.fromARGB(255, 9, 217, 36),
                          //  ),
                          child: const Text(
                            "Enter Zone",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Welcome to Zen Zone",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color((0xFFEEF0F5))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
