import 'dart:convert';

import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjdata.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/ghjfacts.dart';
import 'package:d7/ghjhotels_page.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjplaces.dart';
import 'package:d7/ghjquiz.dart';
import 'package:d7/ghjselected_hotel.dart';
import 'package:d7/ghjsettings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ghjMainPage extends StatefulWidget {
  const ghjMainPage({super.key});

  @override
  State<ghjMainPage> createState() => _ghjMainPageState();
}

class _ghjMainPageState extends State<ghjMainPage> {
  int _ghjselectedIndex = 0;

  void _ghjonItemTappedIcon(int index) {
    setState(() {
      _ghjselectedIndex = index;
    });
  }

  List<Widget> ghjpages = [
    SizedBox.shrink(),
    ghjHotelsPage(),
    ghjfactsPage(),
    ghjPlacesPage(),
    QuizPage(),
  ];
  @override
  Widget build(BuildContext context) {
    double ghjwidth = MediaQuery.sizeOf(context).width;

    final List ghjdecodedBody = jsonDecode(
        getIt.get<ghjDataProvider>().prefs.getStringList('hotels')!.toString());
    return Scaffold(
      backgroundColor: const Color(0xff022D21),
      appBar: _ghjselectedIndex == 0
          ? AppBar(
              title: const Text(
                'What do you \nwant to do?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => SettingsPage()));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffFFE83A),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/settings.svg'),
                      ),
                    ),
                  ),
                )
              ],
            )
          : null,
      body: _ghjselectedIndex == 0
          ? SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Hotels',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _ghjselectedIndex = 1;
                            });
                          },
                          child: Text('View All',
                              style: GoogleFonts.inter(
                                  color: mainColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 250,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => SelectedHotel(
                                              indexOfHotel: index,
                                            )));
                              },
                              child: Container(
                                height: 240,
                                width: 165,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 0),
                                          Color.fromRGBO(0, 0, 0, 0.5),
                                        ]),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            ghjhotels[index]['images'][0]),
                                        fit: BoxFit.fitHeight,
                                        opacity: 0.9)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              ghjhotels[index]['title'],
                                              overflow: TextOverflow.fade,
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/loc.svg',
                                            color: const Color(0xffFFE83A),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Falls Avenue',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${ghjhotels[index]['price']} / night',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/star.svg'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${(ghjhotels[index]['rating'] + (ghjdecodedBody[index]['rate'] / 100)).toStringAsFixed(2)}',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 5,
                          );
                        },
                        itemCount: ghjhotels.length),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _ghjselectedIndex = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff317713),
                                  Color(0xff279B4C)
                                ])),
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFFE83A)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        'assets/nav_bar/2.svg',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Facts',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Interesting and unusual facts\nthat will be useful to you',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _ghjselectedIndex = 3;
                              });
                            },
                            child: Container(
                              width: ghjwidth / 2 - 12.5,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff7EAD34),
                                        Color(0xffFFBC6A)
                                      ])),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFFE83A)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              'assets/nav_bar/1.svg',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Places',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Interesting places and attractions worth visiting',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _ghjselectedIndex = 4;
                              });
                            },
                            child: Container(
                              width: ghjwidth / 2 - 12.5,
                              height: 180,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff71992B),
                                        Color(0xff0DA97B)
                                      ])),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xffFFE83A)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              'assets/nav_bar/4.svg',
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Quiz',
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Take an interesting quiz and find out your capabilities',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          : ghjpages.elementAt(_ghjselectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1C5839),
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/nav_bar/3.svg',
              height: 30,
              color: mainColor,
            ),
            icon: SvgPicture.asset(
              'assets/nav_bar/3.svg',
              color: Colors.white,
              height: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/nav_bar/5.svg',
                height: 30, color: mainColor),
            icon: SvgPicture.asset(
              'assets/nav_bar/5.svg',
              height: 30,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/nav_bar/2.svg',
                height: 30, color: mainColor),
            icon: SvgPicture.asset(
              'assets/nav_bar/2.svg',
              height: 30,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/nav_bar/1.svg',
              height: 30,
              color: mainColor,
            ),
            icon: SvgPicture.asset(
              'assets/nav_bar/1.svg',
              height: 30,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/nav_bar/4.svg',
              height: 30,
              color: mainColor,
            ),
            icon: SvgPicture.asset(
              'assets/nav_bar/4.svg',
              height: 30,
              color: Colors.white,
            ),
            label: '',
          ),
        ],
        currentIndex: _ghjselectedIndex,
        onTap: _ghjonItemTappedIcon,
      ),
    );
  }
}
