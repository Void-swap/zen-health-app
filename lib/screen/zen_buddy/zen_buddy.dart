import 'dart:convert';
import 'dart:ui';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ZenBuddy extends StatefulWidget {
  const ZenBuddy({super.key});

  @override
  State<ZenBuddy> createState() => _ZenBuddyState();
}

class _ZenBuddyState extends State<ZenBuddy> {
  ChatUser myself = ChatUser(id: '1', firstName: 'User');
  ChatUser bot = ChatUser(id: '2', firstName: 'Zen Buddy');

  List<ChatMessage> allMessages = [];
  List<ChatUser> typing = [];

  final oururl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBjI8Gqg_LYjtI9uvKXDwUD9uTrJuBCjkU";

  final header = {'Content-Type': 'application/json'};

  getdata(ChatMessage m) async {
    typing.add(bot);
    allMessages.insert(0, m);
    setState(() {});

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        print(result['candidates'][0]['content']['parts'][0]['text']);

        ChatMessage m1 = ChatMessage(
            text: result['candidates'][0]['content']['parts'][0]['text'],
            user: bot,
            createdAt: DateTime.now());

        allMessages.insert(0, m1);
      } else {
        print("Error occured");
      }
    }).catchError((e) {});
    typing.remove(bot);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Zen Buddy',
            style: TextStyle(fontFamily: 'JekoBold'),
          ),
          actions: [],
        ),
        body: Stack(
          children: [
            Positioned(
              left: -100,
              top: -75,
              child: Transform.scale(
                scale: 0.5,
                child: Lottie.asset(
                  'assets/LottieAssets/zen-buddy-animation.json',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: const SizedBox(),
              ),
            ),
            DashChat(
                typingUsers: typing,
                currentUser: myself,
                onSend: (ChatMessage m) {
                  getdata(m);
                },
                messages: allMessages),
          ],
        ));
  }
}
