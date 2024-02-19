import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'virtualDoc_page.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> doctorDetails;

//mail
  Future<void> _sendEmail(String email) async {
    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(_emailLaunchUri.toString())) {
      await launch(_emailLaunchUri.toString());
    } else {
      throw 'Could not launch email';
    }
  }

  const DoctorDetailsPage({Key? key, required this.doctorDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF7165D6),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const VirtualDoc()),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(doctorDetails['photo'])),
                              const SizedBox(height: 9),
                              Text(
                                doctorDetails['name'],
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                doctorDetails['speciality'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String? Contacts =
                                          doctorDetails['phone'].toString();
                                      launch("tel://$Contacts");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0x0ff9f7e2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    onTap: () {
                                      _sendEmail(doctorDetails['email']);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Color(0x0ff9f7e2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.chat_bubble_text_fill,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.95),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          // maxLines: 1,
                          "About " + doctorDetails['name'] + " : ",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          doctorDetails['description '],
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        //SizedBox(height: 19),
                        /*Row(
                          children: [
                            Text(
                              "Reviews",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              "4.9",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "124",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Color(0xFF7165D6),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "See All",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xFF7165D6),
                                ),
                              ),
                            )
                          ],
                        ),*/
                        const SizedBox(height: 15),
                        const Text(
                          "Location",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.location_on,
                              color: Color(0xFF7165D6),
                              size: 30,
                            ),
                          ),
                          title: Text(doctorDetails['location'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45)),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Availabe Timings",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.timer_outlined,
                              color: Color(0xFF7165D6),
                              size: 30,
                            ),
                          ),
                          title: Text(doctorDetails['timings'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45)),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "Services",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.supervised_user_circle_outlined,
                              color: Color(0xFF7165D6),
                              size: 30,
                            ),
                          ),
                          title: Text(doctorDetails['services'],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        // ),
        // bottomNavigationBar: Container(
        //   padding: const EdgeInsets.all(15),
        //   height: 139,
        //   decoration: const BoxDecoration(
        //     color: Colors.white,
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.black38,
        //         blurRadius: 4,
        //         spreadRadius: 2,
        //       ),
        //     ],
        //   ),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           const Text(
        //             "Consultation Fees :",
        //             style: TextStyle(
        //               color: Colors.black54,
        //             ),
        //           ),
        //           Text(
        //          ' \$${doctorDetails['consultation fees'].toString()}',
        //             style: const TextStyle(
        //               fontSize: 20,
        //               color: Colors.black45,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           )
        //         ],
        //       ),
        //       const SizedBox(height: 15),
        //       InkWell(
        //         onTap: () {},
        //         child: Container(
        //           width: MediaQuery.of(context).size.width,
        //           padding: const EdgeInsets.symmetric(vertical: 18),
        //           decoration: BoxDecoration(
        //             color: const Color(0xFF7165D6),
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           child: const Center(
        //             child: Text(
        //               "Book Appointment",
        //               style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 18,
        //                   fontWeight: FontWeight.w500),
        //             ),
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
      ),
    );
  }
}
