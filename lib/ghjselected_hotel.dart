import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjdata.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjsettings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SelectedHotel extends StatefulWidget {
  final int indexOfHotel;

  const SelectedHotel({super.key, required this.indexOfHotel});

  @override
  State<SelectedHotel> createState() => _SelectedHotelState();
}

class _SelectedHotelState extends State<SelectedHotel> {
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  int ghjselectedPageIndex = 0;
  String ghjdatePicked = '';
  dynamic ghjhotel;
  List<dynamic> ghjcomments = [];
  int ghjrate = 0;
  int ghjselectedImage = 0;

  bool ghjbooked = false;
  List<DateTime?> _ghjselectedDateRange = [
    DateTime(2024, 9, 27),
    DateTime(2024, 9, 30),
  ];

  @override
  void initState() {
    super.initState();

    final ghjbody =
        getIt.get<ghjDataProvider>().prefs.getStringList('hotels') ?? [];
    ghjhotel = jsonDecode(ghjbody[widget.indexOfHotel]);

    ghjcomments = ghjhotel['coments'] ?? [];
    ghjrate = ghjhotel['rate'];

    ghjbooked = ghjhotel['booked'];
    ghjdatePicked = ghjhotel['date'];

    setState(() {});
  }

  void updateRating(int newRating) async {
    setState(() {
      ghjrate = newRating;
      ghjhotel['rate'] = ghjrate;
    });

    final body =
        getIt.get<ghjDataProvider>().prefs.getStringList('hotels') ?? [];
    body[widget.indexOfHotel] = jsonEncode(ghjhotel);
    await getIt.get<ghjDataProvider>().prefs.setStringList('hotels', body);
  }

  void addComment() async {
    if (commentController.text.isNotEmpty) {
      setState(() {
        ghjcomments.add({
          'text': commentController.text,
          'name': nameController.text.isNotEmpty ? nameController.text : 'User',
        });
        commentController.clear();
        nameController.clear();
      });

      ghjhotel['coments'] = ghjcomments;

      final body =
          getIt.get<ghjDataProvider>().prefs.getStringList('hotels') ?? [];
      body[widget.indexOfHotel] = jsonEncode(ghjhotel);
      await getIt.get<ghjDataProvider>().prefs.setStringList('hotels', body);
    }
  }

  Widget buildTabButton(String label, int index) {
    return GestureDetector(
      onTap: () => setState(() => ghjselectedPageIndex = index),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: ghjselectedPageIndex == index ? mainColor : Colors.transparent,
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: ghjselectedPageIndex == index ? Colors.black : Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff022D21),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SettingsPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffFFE83A),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/settings.svg',
                  ),
                ),
              ),
            ),
          )
        ],
        leadingWidth: 126,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, color: mainColor),
                Text(
                  'Back',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            // Hotel Image and Info
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff1C5839),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 228,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                            ghjhotels[widget.indexOfHotel]['images'][0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                ghjhotels[widget.indexOfHotel]['title'],
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/loc.svg',
                              color: const Color(0xffFFE83A),
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Falls Avenue',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${ghjhotels[widget.indexOfHotel]['price']} / night',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                            Row(
                              children: [
                                SvgPicture.asset('assets/star.svg'),
                                SizedBox(width: 5),
                                Text(
                                  '${(ghjhotels[widget.indexOfHotel]['rating'] + (ghjrate / 100)).toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tab Selection
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xff1C5839),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildTabButton('Description', 0),
                    buildTabButton(' Roomtour ', 1),
                    buildTabButton(' Booking ', 2),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            // Tab Content
            if (ghjselectedPageIndex == 0) ...[
              // Description Tab
              Text(
                ghjhotels[widget.indexOfHotel]['description'],
                style: GoogleFonts.inter(
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: const Color(0xffA6F0B5),
                ),
              ),
              SizedBox(height: 10),

              // Rate Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rate this hotel?',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/star.svg', color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        '${(ghjhotels[widget.indexOfHotel]['rating'] + ghjrate * 0.01).toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Rating Stars
              Row(
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => updateRating(index + 1),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SvgPicture.asset(
                        'assets/g.svg',
                        color: index < ghjrate ? Colors.yellow : null,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 10),

              // Comments Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/comment.svg',
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '${ghjhotel['coments'].length}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Comments List
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ghjhotel['coments'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1C5839),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    ghjcomments[index]['name'],
                                    style: GoogleFonts.inter(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    ghjcomments[index]['text'],
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 15),
              TextField(
                onChanged: (value) {
                  setState(() {
                    nameController.text = value;
                  });
                },
                controller: nameController,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 16,
                ),
                textInputAction: TextInputAction.done,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  fillColor: const Color(0xff1C5839),
                  filled: true,
                  hintText: 'Your Name',
                  hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 142,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      commentController.text = value;
                    });
                  },
                  controller: commentController,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textInputAction: TextInputAction.done,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    fillColor: const Color(0xff1C5839),
                    filled: true,
                    hintText: 'Your Message',
                    hintStyle: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: addComment,
                child: Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Add Comment',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],

            if (ghjselectedPageIndex == 1) ...[
              Container(
                width: double.infinity,
                height: 228,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(ghjhotels[widget.indexOfHotel]['images']
                        [ghjselectedImage]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          ghjselectedImage = index;
                        });
                      },
                      child: Container(
                        width: 74,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ghjselectedImage == index
                                  ? mainColor
                                  : Colors.transparent,
                              width: 2),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(ghjhotels[widget.indexOfHotel]
                                ['images'][index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }))
            ],
            SizedBox(
              height: 10,
            ),
            if (ghjselectedPageIndex == 2) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ghjbooked ? "You're booked" : 'Would you like to book',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/bag.svg',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff1C5839),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SvgPicture.asset(
                          'assets/calendar.svg',
                          color: const Color(0xffFFE83A),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'When?',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                      Text(ghjdatePicked,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: const Color(0xff1C5839),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        SvgPicture.asset(
                          'assets/Users.svg',
                          color: const Color(0xffFFE83A),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Guests',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                      Text('1 guest',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(0xff1C5839),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          'When?',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: Container(
                            width: MediaQuery.of(context).size.width *
                                0.9, // Ensure enough width for content
                            height: 350,
                            child: Column(
                              children: [
                                Expanded(
                                  child: CalendarDatePicker2(
                                    config: CalendarDatePicker2Config(
                                      weekdayLabelTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      dayTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      monthTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      selectedMonthTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      selectedDayTextStyle: TextStyle(
                                        color: Colors.black,
                                      ),
                                      selectedRangeDayTextStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      calendarType:
                                          CalendarDatePicker2Type.range,
                                      firstDate: DateTime(2020),
                                      disableMonthPicker: true,

                                      lastDate: DateTime(2025),
                                      lastMonthIcon: SizedBox.shrink(),
                                      nextMonthIcon: SizedBox.shrink(),

                                      selectedDayHighlightColor: mainColor,
                                      centerAlignModePicker: true,
                                      controlsHeight:
                                          100, // Control height of the calendar header
                                      controlsTextStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize:
                                            10, // Reduce font size if needed
                                      ),
                                    ),
                                    value: _ghjselectedDateRange,
                                    onValueChanged: (dates) {
                                      setState(() {
                                        _ghjselectedDateRange = dates;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          GestureDetector(
                            onTap: () async {
                              _showSelectedDateRange();
                              final body = getIt
                                      .get<ghjDataProvider>()
                                      .prefs
                                      .getStringList('hotels') ??
                                  [];
                              ghjhotel['booked'] = true;
                              ghjhotel['date'] = ghjdatePicked;

                              body[widget.indexOfHotel] = jsonEncode(ghjhotel);
                              await getIt
                                  .get<ghjDataProvider>()
                                  .prefs
                                  .setStringList('hotels', body);
                              setState(() {
                                ghjbooked = true;
                              });
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: const Color(0xff1C5839),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: Center(
                                      child: Text(
                                        'Thank you for your\nsubmission!',
                                        style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    content: Text(
                                      'You have successfully booked this hotel. Have a nice day',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: mainColor,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            width: double.infinity,
                                            child: Center(
                                              child: Text(
                                                'Ok',
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'Done',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Visibility(
                  visible: ghjbooked ? false : true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Booking now',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectedDateRange() {
    final start = _ghjselectedDateRange[0];
    final end = _ghjselectedDateRange[1];
    print(_ghjselectedDateRange);
    if (start != null && end != null) {
      setState(() {
        ghjdatePicked =
            '${start.day}-${end.day} ${_ghjformatMonth(start.month)}';
      });
    }
  }

  String _ghjformatMonth(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
