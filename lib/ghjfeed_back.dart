import 'package:d7/ghjapp_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ghjFeedBackPage extends StatefulWidget {
  const ghjFeedBackPage({super.key});

  @override
  State<ghjFeedBackPage> createState() => _ghjFeedBackPageState();
}

class _ghjFeedBackPageState extends State<ghjFeedBackPage> {
  TextEditingController ghjcontroller1 = TextEditingController();
  TextEditingController ghjjklcontroller2 = TextEditingController();
  TextEditingController ghjjklcontroller3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff022D21),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 345,
        child: CupertinoButton(
            borderRadius: BorderRadius.circular(56),
            color: mainColor,
            child: Text(
              'Send',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.black),
            ),
            onPressed: () {
              if (ghjcontroller1.text.isEmpty ||
                  ghjjklcontroller2.text.isEmpty ||
                  ghjjklcontroller3.text.isEmpty == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fill in all the fields')));
              } else {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor:
                          Color(0xff022D21), // Dark gray background color
                      child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Message sent!',
                              style: TextStyle(
                                color: mainColor, // Orange text color
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                              ),
                              child: Text(
                                'Continue',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
      ),
      appBar: AppBar(
        leadingWidth: 126,
        centerTitle: false,
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
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Contact Us',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  child: TextField(
                    controller: ghjcontroller1,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,

                      isDense: true,
                      fillColor:
                          const Color(0xff1C5839), // Dark gray background
                      hintText: 'Your Name',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none, // No border
                      ),
                    ),
                    style:
                        TextStyle(color: Colors.white), // White text for input
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  child: TextField(
                    controller: ghjjklcontroller2,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: const Color(0xff1C5839),
                      hintText: 'Your Email',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 142,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        ghjjklcontroller3.text = value;
                      });
                    },
                    cursorColor: Colors.white,
                    controller: ghjjklcontroller3,
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
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
