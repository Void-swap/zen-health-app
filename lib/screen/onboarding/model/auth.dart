import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

String? userEmail;
String? name;
String? uid;
String? imageUrl;

//handles Google Signin
Future<User?> signInWithGoogle() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCrmVB7i2EnsMMOuC6YomdV-HSwUI_tC5g",
    projectId: "zen-health-9",
    messagingSenderId: "392656862851",
    appId: "1:392656862851:web:eb03e4dae51d4a4e2965b6",
  ));
  User? user;
  if (kIsWeb) {
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential =
          await _auth.signInWithPopup(authProvider);

      user = userCredential.user;
    } catch (e) {
      print(e);
    }
  } else {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print("already exist withh diff pass");
        } else if (e.code == 'invalid-credential') {
          print("Invalid,Try again");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  if (user != null) {
    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("auth", true);
  }
  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("auth", false);
  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;
}
