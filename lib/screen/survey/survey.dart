import 'package:flutter/material.dart';
import 'package:zen_health/screen/survey/survey_Day.dart';

class SurveyIntroScreen extends StatelessWidget {
  const SurveyIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig2().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.network(
            'https://i.pinimg.com/564x/dc/f8/8f/dcf88fe17069fa4ec22df729811cf567.jpg',
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 100, // Adjust this value as needed
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig2.safeHorizontal! * 0.07,
                  ),
                  child: Text(
                    'Mental Health\nAssessment',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black,
                          fontFamily: 'JekoBold',
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig2.safeVertical! * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig2.safeHorizontal! * 0.07,
                  ),
                  child: const Text(
                    "Welcome to Health Assessment!\nLet's take the first step together –\nit's all about you and your well-being!",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'JekoBold',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: SizeConfig2.safeVertical! * 0.03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig2.safeHorizontal! * 0.07,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DaySurvey()),
                      );
                    },
                    icon: const Icon(Icons.arrow_right_outlined),
                    label: const Text("Continue",
                        style: TextStyle(
                            color: const Color(0xff36454F), fontSize: 15)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizeConfig2 {
  static double? safeHorizontal;
  static double? safeVertical;

  void init(BuildContext context) {
    safeHorizontal = MediaQuery.of(context).size.width -
        MediaQuery.of(context).padding.left +
        MediaQuery.of(context).padding.right;
    safeVertical = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top +
        MediaQuery.of(context).padding.bottom;
  }
}
