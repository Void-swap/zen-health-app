// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dummy_thankyou.dart';

class DaySurvey extends GetView<SurveyController> {
  const DaySurvey({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> phqQuestions = [
      'Question 1: In social situations, do you often feel excessively nervous or anxious?',
      'Question 2: Are you experiencing persistent sadness and a loss of interest in activities you used to enjoy?',
      'Question 3: Do you have recurring nightmares or flashbacks related to a traumatic incident?',
      'Question 4: Is it challenging for you to sustain attention and frequently make careless mistakes?',
      'Question 5: Are you often irritable and have difficulty controlling your worry?',
      'Question 6: Do you feel emotionally numb and detached from others?',
      'Question 7: Are you forgetful in daily activities and tasks?',
      'Question 8: Are you often restless, excessively fidgeting, or unable to sit still?',
      'Question 9: Do you avoid situations that trigger intense anxiety or distress?',
      'Question 10: Are you experiencing changes in appetite and weight?',
      // Add more PHQ-9 questions as needed
    ];

    final currQuestion = phqQuestions[SurveyController.to.progressNum - 1];

    SizeConfig().init(context);
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 30),
            Container(
              child: Obx(() => CustomIntervalProgressBar(
                    max: 9,
                    progress: SurveyController.to.progressNum,
                    intervalSize: 5,
                  )),
            ),
            const SizedBox(height: 30),
            Obx(() {
              final currQuestion =
                  phqQuestions[SurveyController.to.progressNum - 1];

              return Text(
                currQuestion,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.black,
                    fontFamily: 'JekoBlack',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              );
            }),
            Obx(
              () => QuestionScreen(
                child0: Text(
                  'Not\nat all',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontFamily: 'JekoBlack',
                      ),
                  textAlign: TextAlign.center,
                ),
                child1: Text(
                  'On\nSeveral\ndays',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontFamily: 'JekoBlack',
                      ),
                  textAlign: TextAlign.center,
                ),
                child2: Center(
                  child: Text(
                    'More\nthan half\nthe days',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: Colors.black,
                          fontFamily: 'JekoBlack',
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                child3: Text(
                  'Nearly\nevery day',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontFamily: 'JekoBlack',
                      ),
                  textAlign: TextAlign.center,
                ),
                svgPath:
                    'assets/text/question-${SurveyController.to.progressNum}.svg',
                onTap0: () {
                  SurveyController.to.Card0Selected();
                },
                onTap1: () {
                  SurveyController.to.Card1Selected();
                },
                onTap2: () {
                  SurveyController.to.Card2Selected();
                },
                onTap3: () {
                  SurveyController.to.Card3Selected();
                },
              ),
            ),
            const SizedBox(height: 30),
            // Spacer(),
            RoundedButton(
              bgColor: Colors.black,
              text: 'submit',
              onClicked: () {
                SurveyController.to.updateProgressNumber(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SurveyController extends GetxController {
  static SurveyController get to => Get.put(SurveyController());

  final _progressNum = 1.obs;
  get progressNum => this._progressNum.value;
  set progressNum(value) => this._progressNum.value = value;

  final _isCard0Selected = false.obs;
  get isCard0Selected => this._isCard0Selected.value;
  set isCard0Selected(value) => this._isCard0Selected.value = value;

  final _isCard1Selected = false.obs;
  get isCard1Selected => this._isCard1Selected.value;
  set isCard1Selected(value) => this._isCard1Selected.value = value;

  final _isCard2Selected = false.obs;
  get isCard2Selected => this._isCard2Selected.value;
  set isCard2Selected(value) => this._isCard2Selected.value = value;

  final _isCard3Selected = false.obs;
  get isCard3Selected => this._isCard3Selected.value;
  set isCard3Selected(value) => this._isCard3Selected.value = value;

  void turnOffAllSelections() {
    isCard0Selected = false;
    isCard1Selected = false;
    isCard2Selected = false;
    isCard3Selected = false;
  }

  void Card0Selected() {
    turnOffAllSelections();
    isCard0Selected = true;
  }

  void Card1Selected() {
    turnOffAllSelections();
    isCard1Selected = true;
  }

  void Card2Selected() {
    turnOffAllSelections();
    isCard2Selected = true;
  }

  void Card3Selected() {
    turnOffAllSelections();
    isCard3Selected = true;
  }

  void updateProgressNumber(BuildContext context) {
    if (isCard0Selected ||
        isCard1Selected ||
        isCard2Selected ||
        isCard3Selected) {
      if (progressNum == 9) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ThankYouPage()),
        );
      } else {
        progressNum += 1;
        turnOffAllSelections();
      }
    }
  }
}

class RoundedButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final VoidCallback onClicked;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.bgColor,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        elevation: 0,
        fixedSize: Size(
            SizeConfig.safeHorizontal! * .85, SizeConfig.safeVertical! * .065),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      onPressed: onClicked,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white, fontFamily: 'JekoBold'),
      ),
    );
  }
}

class SizeConfig {
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

class QuestionScreen extends StatelessWidget {
  final String svgPath;
  final Widget child0;
  final Widget child1;
  final Widget child2;
  final Widget child3;
  final VoidCallback onTap0;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final VoidCallback onTap3;

  const QuestionScreen({
    Key? key,
    required this.svgPath,
    required this.child0,
    required this.child1,
    required this.child2,
    required this.child3,
    required this.onTap0,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        // SizedBox(
        //   height: SizeConfig.safeVertical! * 0.01,
        // ),
        // Center(
        //   child: SvgPicture.asset(
        //     svgPath,
        //     fit: BoxFit.contain,
        //     width: SizeConfig.safeHorizontal! * 0.85,
        //   ),
        // ),
        SizedBox(
          height: SizeConfig.safeVertical! * 0.07,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => ShadowBox(
                ht: SizeConfig.safeVertical! * .18,
                wd: SizeConfig.safeVertical! * .18,
                isSelected: SurveyController.to.isCard0Selected,
                onClicked: onTap0,
                child: Center(
                  child: child0,
                ),
              ),
            ),
            Obx(
              () => ShadowBox(
                ht: SizeConfig.safeVertical! * .18,
                wd: SizeConfig.safeVertical! * .18,
                isSelected: SurveyController.to.isCard1Selected,
                onClicked: onTap1,
                child: Center(
                  child: child1,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeVertical! * 0.05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => ShadowBox(
                ht: SizeConfig.safeVertical! * .18,
                wd: SizeConfig.safeVertical! * .18,
                isSelected: SurveyController.to.isCard2Selected,
                onClicked: onTap2,
                child: Center(
                  child: child2,
                ),
              ),
            ),
            Obx(
              () => ShadowBox(
                ht: SizeConfig.safeVertical! * .18,
                wd: SizeConfig.safeVertical! * .18,
                isSelected: SurveyController.to.isCard3Selected,
                onClicked: onTap3,
                child: Center(
                  child: child3,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShadowBox extends StatelessWidget {
  final double ht;
  final double wd;
  final bool isSelected;
  final Widget child;
  final VoidCallback onClicked;

  const ShadowBox({
    Key? key,
    required this.ht,
    required this.wd,
    this.isSelected = false,
    required this.child,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        height: ht,
        width: wd,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.28),
              spreadRadius: 5,
              blurRadius: 50,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class CustomIntervalProgressBar extends StatelessWidget {
  final int max;
  final int progress;
  final int intervalSize;

  const CustomIntervalProgressBar({
    Key? key,
    required this.max,
    required this.progress,
    required this.intervalSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LinearProgressIndicator(
          value: progress / max,
          minHeight: 10,
          backgroundColor: Colors.transparent,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
        ),
        ...buildIntervals(),
      ],
    );
  }

  List<Widget> buildIntervals() {
    List<Widget> intervals = [];

    for (int i = 0; i < max; i++) {
      intervals.add(
        Positioned(
          left: (i / max) * 100,
          child: Container(
            width: 1,
            height: 10,
            color: i % intervalSize == 0 ? Colors.black : Colors.transparent,
          ),
        ),
      );
    }
    return intervals;
  }
}
