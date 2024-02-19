import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'model/msg_model.dart';
import 'msg_widget/other_msg_widget.dart';
import 'msg_widget/own_msg_widget.dart';

class ZenZone extends StatefulWidget {
  const ZenZone({Key? key, required this.name, required this.userId})
      : super(key: key);
  final String name;
  final String userId;

  @override
  _ZenZoneState createState() => _ZenZoneState();
}

class _ZenZoneState extends State<ZenZone> {
  IO.Socket? socket;
  List<MsgModel> listMsg = [];
  final TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO
        .io('https://zen-server-void-swap-oyvz.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connected to backend server');
      socket!.on('sendMsgServer', (msg) {
        print(msg);
        if (msg['userId'] != widget.userId) {
          setState(() {
            listMsg.add(MsgModel(
              msg: msg['msg'],
              type: msg['type'],
              sender: msg['senderName'],
            ));
          });
        }
      });
    });
  }

  void sendMsg(String msg, String senderName) {
    MsgModel ownMsg = MsgModel(
      msg: msg,
      type: 'ownMsg',
      sender: senderName,
    );
    listMsg.add(ownMsg);
    setState(() {
      listMsg;
    });
    socket!.emit('sendMsg', {
      'type': 'ownMsg',
      'msg': msg,
      'senderName': senderName,
      'userId': widget.userId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Welcome to Zen Zone',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Lottie.asset(
              'assets/LottieAssets/zen_background.json',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                child: const SizedBox(),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listMsg.length,
                    itemBuilder: (context, index) {
                      if (listMsg[index].type == 'ownMsg') {
                        return OwnMsgWidget(
                          sender: listMsg[index].sender,
                          msg: listMsg[index].msg,
                        );
                      } else {
                        return OtherMsgWidget(
                          sender: listMsg[index].sender,
                          msg: listMsg[index].msg,
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 28),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _msgController,
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.2),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                String msg = _msgController.text;
                                if (msg.isNotEmpty) {
                                  sendMsg(msg, widget.name);
                                  _msgController.clear();
                                }
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.black87,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
