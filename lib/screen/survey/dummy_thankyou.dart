import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/user_data.dart';

class ThankYouPage extends StatelessWidget {
  ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.thumb_up,
              size: 80,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Consumer<UserData>(
              builder: (context, userData, _) {
                return Text(
                  "Kudos ${userData.userName}, on completing the survey! \n We'll be in touch soon",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: Text(
                'Go Back',
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
