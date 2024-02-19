import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zen_health/screen/entry_screen/entry_point.dart';

import 'data/user_data.dart';
import 'screen/onboarding/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
        //for APP initialize in main & web in future
        options: FirebaseOptions(
      apiKey: "AIzaSyCrmVB7i2EnsMMOuC6YomdV-HSwUI_tC5g",
      projectId: "zen-health-9",
      messagingSenderId: "392656862851",
      appId: "1:392656862851:web:eb03e4dae51d4a4e2965b6",
    ));
  }
  UserData userData = UserData();
  await userData.loadName();
  await Hive.initFlutter();
  var box = await Hive.openBox("Habit_Database");
  //check device
  runApp(
    ChangeNotifierProvider<UserData>(
      create: (context) => UserData(),
      child: kIsWeb ? WebApp() : MobileApp(),
    ),
  );
}

class WebApp extends StatelessWidget {
  WebApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyCrmVB7i2EnsMMOuC6YomdV-HSwUI_tC5g",
    projectId: "zen-health-9",
    messagingSenderId: "392656862851",
    appId: "1:392656862851:web:eb03e4dae51d4a4e2965b6",
  ));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: EntryPoint()),
    );
  }
}

class MobileApp extends StatelessWidget {
  MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user != null) {
              // User is signed in
              return const EntryPoint();
            } else {
              // User not signed IN
              return const OnboardingScreen(); // Navigate to the Login screen.
            }
          } else {
            // Handle the LOADING state
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
