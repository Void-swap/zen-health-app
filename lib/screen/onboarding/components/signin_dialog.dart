import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zen_health/screen/entry_screen/entry_point.dart';
import 'package:zen_health/screen/onboarding/onboarding_screen.dart';

import '../model/auth.dart';
import 'signin_form.dart';
//import 'package:rive_animation/screen/onboding/components/sign_in_form.dart';

Future<Object?> CustomSigninDialog(BuildContext context) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: "Sign-In",
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
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 100,
        ),
        padding: const EdgeInsets.only( left: 24, right: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Scaffold(
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
                        "Sign In",
                        style: GoogleFonts.poppins(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Welcome to Zen Health",
                          style: GoogleFonts.poppins(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SignInForm(),
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
                            onPressed: () async {
                              User? user = await signInWithGoogle();
                              if (user != null) {
                                // Signed in successfully, navigate to the onboarding screen
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => OnboardingScreen(),
                                ));
                              } else {
                                // Sign-in failed or was canceled by the user
                                showDialog(
                                  context: context,
                                  builder: (context) => LoginFailedDialog(),
                                );
                              }
                            },
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
                            onPressed: () async {
                              User? user = await signInWithGoogle();
                              if (user != null) {
                                // Signed in successfully, navigate to the EntryPoint
                                EntryPoint();
                              } else {
                                // Sign-in failed or was canceled by the user
                                LoginFailedDialog();
                              }
                            },
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
                ],
              ),
            ],
          ),
          // floatingActionButton: const Positioned(
          //   left: 0,
          //   right: 10,
          //   bottom: 15,
          //   child: CircleAvatar(
          //     radius: 16,
          //     backgroundColor: Colors.white,
          //     child: Icon(
          //       Icons.close,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
        ),
      ),
    ),
  );
}

class LoginFailedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        'Login Failed',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your username or password is incorrect. Please try again.',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

Future<User?> signInWithGoogle2() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return authResult.user;
    }
    return null;
  } catch (error) {
    print(error);
    return null;
  }
}
