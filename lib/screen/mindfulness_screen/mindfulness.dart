import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

const kBackgroundColor = Color(0xFFF8F8F8);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);

class SearchBar extends StatelessWidget {
  const SearchBar({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29.5),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          icon: Icon(Icons.search), // Use a regular Icon instead of SVG
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class Mindfulness extends StatelessWidget {
  const Mindfulness({Key? key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .5,
            decoration: BoxDecoration(
              color: kBlueLightColor,
              image: DecorationImage(
                image: AssetImage("assets/images/meditation_bg.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      "Meditation",
                      style: TextStyle(
                     fontFamily: "JekoBold",
                          fontSize: 32,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "3-10 MIN Course",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: size.width * .6,
                      child: Text(
                        "Live happier and healthier by learning the fundamentals of meditation and mindfulness",
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5,
                      child: SearchBar(key: UniqueKey()),
                    ),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: <Widget>[
                        SeassionCard(
                            seassionNum: 1,
                            isDone: true,
                            audioUrl:
                                'https://github.com/Void-swap/zen_server/assets/136692389/2699c658-251b-48d6-b6a4-a46ad3113da1'),
                        SeassionCard(
                          seassionNum: 2,
                          isDone: true,
                          audioUrl:
                              'https://github.com/Void-swap/zen_server/assets/136692389/fa9fe3b9-5860-471a-9f86-481868f9fa6f',
                        ),
                        SeassionCard(
                            seassionNum: 3,
                            isDone: true,
                            audioUrl:
                                'https://github.com/Void-swap/zen_server/assets/136692389/87a193b7-8e54-46be-8634-df90dc95b921'),
                        SeassionCard(
                            seassionNum: 4,
                            isDone: true,
                            audioUrl:
                                'https://github.com/Void-swap/zen_server/assets/136692389/2699c658-251b-48d6-b6a4-a46ad3113da1'),
                        SeassionCard(
                          seassionNum: 5,
                          isDone: true,
                          audioUrl:
                              'https://github.com/Void-swap/zen_server/assets/136692389/767a83f8-34e4-4412-ba90-b923913fb7e4',
                        ),
                        SeassionCard(
                            seassionNum: 6,
                            isDone: true,
                            audioUrl:
                                "https://github.com/Void-swap/zen_server/assets/136692389/682860fd-4987-4fd9-bd50-bb3c87093500"),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Meditation",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeassionCard extends StatefulWidget {
  final int seassionNum;
  final bool isDone;
  final String audioUrl;

  SeassionCard({
    Key? key,
    required this.seassionNum,
    required this.isDone,
    required this.audioUrl,
  }) : super(key: key);

  @override
  _SeassionCardState createState() => _SeassionCardState();
}

class _SeassionCardState extends State<SeassionCard> {
  late final AudioPlayer audioPlayer;
  late IconData icon;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    icon = isPlaying ? Icons.pause : Icons.play_arrow;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 10,
          decoration: BoxDecoration(
            color: Color.fromARGB(248, 235, 241, 246),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _toggleAudio();
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: widget.isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        icon,
                        color: widget.isDone ? Colors.white : kBlueColor,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Session ${widget.seassionNum}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _toggleAudio() async {
    setState(() {
      if (isPlaying) {
        audioPlayer.pause();
      } else {
        if (!isPlaying) {
          audioPlayer.setUrl(widget.audioUrl).then((_) {
            audioPlayer.play();
          });
        }
      }

      isPlaying = !isPlaying;
      icon = isPlaying ? Icons.pause : Icons.play_arrow;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
