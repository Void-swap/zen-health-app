import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;

import 'doctors_details.dart';

class VirtualDoc extends StatefulWidget {
  const VirtualDoc({Key? key}) : super(key: key);

  @override
  _VirtualDocState createState() => _VirtualDocState();
}

class _VirtualDocState extends State<VirtualDoc> {
  List<dynamic> doctorsDummy = [];
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    final response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbz4NY-ntHNG6--bLBK6s8EQBMfc9yGQKJeGcUzqNbEiPR2pE_8rY9aBZVyeay8BPsqf0A/exec'));
    if (response.statusCode == 200) {
      setState(() {
        doctorsDummy = json.decode(response.body);
        _loading = false;
      });
    } else {
      setState(() {
        _errorMessage = 'Failed to load data';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : DoctorsDummyBuilder(doctors: doctorsDummy),
    );
  }
}

class DoctorsDummyBuilder extends StatelessWidget {
  const DoctorsDummyBuilder({
    super.key,
    required this.doctors,
  });

  final List doctors;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color(0xFFE0E5EC),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              toolbarHeight: 275,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/memphis.png',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 3,
                    width: double.infinity,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 120),
                      Text(
                        "Virtual Doctor",
                        style: TextStyle(
                            fontFamily: "JekoBold",
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0XFFC1D8E9), // Lighter pastel blue
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TabBar(
                          tabs: [
                            Tab(text: 'All Best Matches'),
                            //Tab(text:"near you")
                          ],
                          labelStyle: TextStyle(fontFamily: 'JekoBlack'),
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.black,
                          unselectedLabelStyle:
                              TextStyle(fontFamily: 'JekoBlack'),
                          indicator: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XFFC1D8E9)
                                    .withOpacity(0.4), // Lighter shadow
                                spreadRadius: 10,
                                blurRadius: 60,
                                offset: Offset(20, 10),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelPadding: EdgeInsets.only(top: 5),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 20),
                      //   child: Image.network(
                      //     'https://img.freepik.com/free-vector/videocalling-with-therapist_52683-37917.jpg?w=740&t=st=1707651206~exp=1707651806~hmac=2b1bb4cf6bca8aafad02774fcaaded20e735a41a245ae1f9593a05a880d27dc9',
                      //     fit: BoxFit.contain,
                      //     width: 200, // Adjust as needed
                      //   ),
                      // ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildList(),
              //near you
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DoctorDetailsPage(doctorDetails: doctors[index]),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GFAvatar(
                          backgroundImage: doctors[index]['photo'] != null
                              ? NetworkImage(doctors[index]['photo'])
                              : NetworkImage(
                                  'https://i2.wp.com/www.kindpng.com/picc/m/252-2524695_dummy-profile-image-jpg-hd-png-download.png'),
                          shape: GFAvatarShape.standard,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctors[index]['name'] != null
                                    ? doctors[index]['name']
                                    : 'XYZ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                doctors[index]['speciality'] != null
                                    ? doctors[index]['speciality']
                                    : 'Therapist',
                                style: TextStyle(
                                    color: Color.fromRGBO(96, 11, 156, 0.6),
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                doctors[index]['location'] != null
                                    ? doctors[index]['location']
                                    : 'No Location',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "About : ",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      doctors[index]['description '] != null
                          ? doctors[index]['description ']
                          : 'XYZ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
