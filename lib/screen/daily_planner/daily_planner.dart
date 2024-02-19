import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:zen_health/utils/rive_utils.dart';
// import 'package:zen_health/zen_bot/zen_bot.dart';
// import 'package:zen_health/zen_zone/zen_entry.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zen_health/screen/daily_planner/components/habit_tile.dart';
// import 'package:zen_health/models/info_card.dart';
// import 'package:zen_health/models/rive_asset.dart';
import 'package:zen_health/screen/daily_planner/components/month_summary.dart';
import 'package:zen_health/screen/daily_planner/components/my_alert_box.dart';
import 'package:zen_health/screen/daily_planner/components/my_fab.dart';
import 'package:zen_health/screen/daily_planner/data/habit_database.dart';
import 'package:zen_health/screen/onboarding/onboarding_screen.dart';

import '../../data/user_data.dart';
import '../../model/info_card.dart';
import '../../model/rive_assest.dart';
import '../entry_screen/components/side_menu_tile.dart';
import '../entry_screen/utils/rive_utils.dart';
import '../zen_buddy/zen_buddy.dart';
import '../zen_zone/zen_entry.dart';

// import '../../components copy/side_menu_tile.dart';
late int counter = 0;
HabitDatabase db = HabitDatabase();
final _myBox = Hive.box("Habit_Database");

class DailyPlanner extends StatefulWidget {
  const DailyPlanner({super.key});

  @override
  State<DailyPlanner> createState() => _DailyPlannerState();
}

class _DailyPlannerState extends State<DailyPlanner> {
  final IconList = [
    Icon(Icons.local_drink),
    Icon(Icons.book),
    Icon(Icons.sports_gymnastics),
    Icon(Icons.language),
    Icon(Icons.computer),
    Icon(Icons.edit),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
    Icon(Icons.abc_sharp),
  ];
  final HabitDecList = [
    "Drink At Least 7 Cups Of Water",
    "Read at least 5 pages",
    "Go to the gym or do cardio",
    "Write Down 3 things that you appreciate",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  // Method to get heatmap data
  Map<DateTime, int>? getHeatMapData() {
    return db.heatMapDataSet; // Return heatmap data from HabitDatabase
  }

  @override
  void initState() {
    // if there is no current habit list, then it is the 1st time ever opening the app
    //  CreAte default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    }

    // If AlreadY exists data, this is not the first time
    else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    super.initState();
  }

  // checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });

    if (value == false) {
      counter -= 1;
      print(counter.toString());
    } else
      counter += 1;
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
      IconList.add(Icon(Icons.abc));
    });

    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();

    // pop dialog box
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  MyFloatingActionButton(onPressed: createNewHabit),
                  SizedBox(
                    width: 15,
                  )
                ],
                backgroundColor: const Color(0xFF9575CD),
                expandedHeight: 220.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Consumer<UserData>(
                    builder: (context, userData, _) {
                      return Text(
                        "Hey ${userData.userName}!", // Use the user's name
                        style: TextStyle(
                          color: const Color(0xFF17203A),
                          fontFamily: 'JekoBold',
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  background: Image.network(
                      'https://i.pinimg.com/564x/8f/dc/a2/8fdca272be92b31e713a37d3cf145672.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "You have ${db.todaysHabitList.length - counter} habits left for today",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey[800],
                              fontSize: 19,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Card(
                      color: Colors.grey[200],
                      elevation: 9,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            color: Colors.deepPurpleAccent,
                            backgroundColor:
                                const Color.fromARGB(255, 192, 170, 250),
                            value: (counter / db.todaysHabitList.length),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: db.todaysHabitList.length,
                      itemBuilder: (context, index) {
                        return HabitTile(
                          habitName: db.todaysHabitList[index][0],
                          habitCompleted: db.todaysHabitList[index][1],
                          habitDesc: HabitDecList[index].isEmpty
                              ? "Custom Habit"
                              : HabitDecList[index],
                          onChanged: (value) => checkBoxTapped(value, index),
                          settingsTapped: (context) => openHabitSettings(index),
                          deleteTapped: (context) => deleteHabit(index),
                          habitIcon: IconList.length > index
                              ? IconList[index]
                              : Icon(Icons.abc_outlined),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.last;

  final List<Widget> screens = [
    const AnonymousChat(),
    const BreathingScreen(),
    const ZenBuddy(),
    const FeedBackScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Transform.translate(
        offset: const Offset(0, 0), // Modify the offset for the desired effect
        child: GestureDetector(
          onTap: () {
            //this will REFRESH our heat map DATASET
            setState(() {});
          },
          child: Container(
            width: 288,
            height: double.infinity,
            color: const Color(0xFF17203A),
            child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Consumer<UserData>(
                      builder: (context, userData, _) {
                        return InfoCard(
                          name: userData.userName, //user's name
                          profession: "User",
                        );
                      },
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 24, top: 16, bottom: 16),
                      child: Text(
                        "Browse".toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white70),
                      ),
                    ),
                    ...sideMenus.asMap().entries.map(
                          (entry) => SideMenuTile(
                            menu: entry.value,
                            riveonInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          entry.value.stateMachineName);
                              entry.value.input =
                                  controller.findSMI("active") as SMIBool;
                            },
                            press: () {
                              entry.value.input!.change(true);
                              Future.delayed(const Duration(seconds: 1), () {
                                entry.value.input!.change(false);
                              });
                              setState(() {
                                selectedMenu = entry.value;
                              });

                              Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        screens[entry.key],
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                                transitionDuration:
                                    const Duration(milliseconds: 1200),
                              ));
                            },
                            isActive: selectedMenu == entry.value,
                          ),
                        ),
                    // const SizedBox(height: 20),
                    Center(
                      child: Transform.scale(
                        scale: 0.95,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ZenHeatMap(
                              datasets: db.heatMapDataSet,
                              startDate: _myBox.get("START_DATE"),
                            ),
                            SizedBox()
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Feedback Button
                        GestureDetector(
                          onTap: () {
                            final url = Uri.parse(
                                "https://forms.gle/x2uFZpkTNykfcYSV7");
                            launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue[500],
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Text(
                              "Feedback",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            signOutAndNavigate(context);
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        SizedBox()
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void signOutAndNavigate(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    );
  }
}

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedBack Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Center(
        child: Text('Welcome to the FeedBack Screen!'),
      ),
    );
  }
}

class BreathingScreen extends StatelessWidget {
  const BreathingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(140, 126, 255, 0.8),
        title: const Text(
          'Breathe',
          style: TextStyle(
              color: Color.fromARGB(220, 255, 255, 255),
              fontFamily: 'JekoBold'),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(220, 255, 255, 255),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Color.fromRGBO(140, 126, 255, 0.9),
        child: Lottie.asset(
          'assets/LottieAssets/breathing.json',
          width: double.infinity,
          height: double.infinity,
          repeat: true,
        ),
      ),
    );
  }
}
