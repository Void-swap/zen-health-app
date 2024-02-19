import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'signup_form.dart';



//import 'package:zen_health/screen/onboding/components/sign_in_form.dart';

Future<Object?> CustomSignUpDialog(BuildContext context) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign-up",
    context: context,
    //TRansition after button is press our SIGN UP PAGE WILL COME DOWN
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => Center(
      child: Container(
        height: 620,
        margin: const EdgeInsets.symmetric(
         horizontal: 10,
          vertical: 100,
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: ListView(
            children: [
              Stack(
                clipBehavior: Clip
                    .none, //takes out the boundaries (we had bug our X icon was hiding behing it)
                children: [
                  Column(
                    children: [
                       Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(fontSize: 34,fontWeight:FontWeight.bold),
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Welcome to Zen Health",style:GoogleFonts.poppins(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SignUpForm(),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Text(
                            "OR",
                            style: TextStyle(color: Colors.black26),
                          ),
                          Expanded(child: Divider()), //Bings a line on SCREEN
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          "Sign-up with Email , Apple or Google",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/email_box.svg",
                              height: 64,
                              width: 64,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/apple_box.svg",
                              height: 64,
                              width: 64,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              "assets/icons/google_box.svg",
                              height: 64,
                              width: 64,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  //this is cross buttn for sign up
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: -70,
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
            ],
          ),
        ),
      ),
    ),
  );
}
