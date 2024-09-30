
import 'dart:convert';

import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjdata.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjsettings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedFact extends StatefulWidget {
  final int ghjselectedfactIndex;
  const SelectedFact({super.key, required this.ghjselectedfactIndex});

  @override
  State<SelectedFact> createState() => _SelectedFactState();
}

class _SelectedFactState extends State<SelectedFact> {
  TextEditingController ghjnameController = TextEditingController();
  TextEditingController ghjcommentController = TextEditingController();
  int ghjselectedPageIndex = 0;
  String ghjdatePicked = '';
  dynamic ghjfact;
  List<dynamic> ghjcomments = [];
  int ghjrate = 0;
  int ghjselectedImage = 0;

  bool ghjbooked = false;
 

  @override
  void initState() {
    super.initState();

    final ghjbody = getIt.get<ghjDataProvider>().prefs.getStringList('facts') ?? [];
    ghjfact = jsonDecode(ghjbody[widget.ghjselectedfactIndex]);

    ghjcomments = ghjfact['coments'] ?? [];
    ghjrate = ghjfact['rate'] ;

    setState(() {
      
    });

  }

  void updateRating(int newRating) async {
    setState(() {
      ghjrate = newRating;
      ghjfact['rate'] = ghjrate;
    });

    final body = getIt.get<ghjDataProvider>().prefs.getStringList('facts') ?? [];
    body[widget.ghjselectedfactIndex] = jsonEncode(ghjfact);
    await getIt.get<ghjDataProvider>().prefs.setStringList('facts', body);
  }

  void addComment() async {
    if (ghjcommentController.text.isNotEmpty) {
      setState(() {
        ghjcomments.add({
          'text': ghjcommentController.text,
          'name': ghjnameController.text.isNotEmpty ? ghjnameController.text : 'User',
        });
        ghjcommentController.clear();
        ghjnameController.clear();
      });

      ghjfact['coments'] = ghjcomments;

      final body = getIt.get<ghjDataProvider>().prefs.getStringList('facts') ?? [];
      body[widget.ghjselectedfactIndex] = jsonEncode(ghjfact);
      await getIt.get<ghjDataProvider>().prefs.setStringList('facts', body);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10,top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, 
                CupertinoPageRoute(builder: (context)=> SettingsPage()));
              },
              child: Container(
                
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 255, 255, 1)
                
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/settings.svg'),
              ),
                      ),
            ),
          )],
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
            Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               color: Color.fromRGBO(255, 255, 255, 1),
                              
                            ),
                            child: Column(children: [
                               
                               Container(
                                
                                width: double.infinity,
                                        height: 228,
                                decoration: BoxDecoration(
                                 
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image:
                                   AssetImage(facts
                                   [widget.ghjselectedfactIndex]['images'][0]),
                                   
                                    fit: BoxFit.cover,
                                    
                                    )
                                ),
                               )   ,
                               Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Row(
                                    children: [
                                   
                                         Expanded(
                                           child: Text(facts
                                   [widget.ghjselectedfactIndex]['title'],
                                                                             
                                           overflow: TextOverflow.fade,
                                           
                                                                       style:
                                           GoogleFonts.inter(
                                             
                                           fontWeight: FontWeight.w800,
                                           color: Colors.black,
                                           fontSize: 16),),
                                         ),
                          
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                 
                                
                          
                          
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                       Row(
                                    children: [
                                        SvgPicture.asset('assets/loc.svg'),
                                        SizedBox(width: 5,),
                                         Text('Falls Avenue',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13),),
                          
                                    ],
                                  ),
                                  Row(
                                    children: [
   SvgPicture.asset('assets/star.svg'),
                                      SizedBox(width: 5,),
                                       Text( '${(facts[widget.ghjselectedfactIndex]['rating'] + 
                                  (ghjrate / 100)).toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 13),),
                                    ],
                                  )
                                   
                                     
                          
                                    ],)
                               
                              ],),
                            ),
                            ],),
                          ),

                          SizedBox(height: 10,),
                           Text(
                facts[widget.ghjselectedfactIndex]['description'],
                style: GoogleFonts.inter(
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
             
              SizedBox(height: 10,),
                

              // Rate Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rate this hotel?',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/star.svg',
                       color: Colors.black),
                      SizedBox(width: 5),
                      Text(
                        '${(facts[widget.ghjselectedfactIndex]['rating']
                         + ghjrate * 0.01).toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
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
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset('assets/comment.svg'),
                      SizedBox(width: 8),
                      Text(
                        '${ghjfact['coments'].length}',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
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
                itemCount: ghjfact['coments'].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 10,),
                            Row(children: [Expanded(
                              child: Text(
                                    ghjcomments[index]['text'],
                                    style: GoogleFonts.inter(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            ),],)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

        
              SizedBox(height: 15),
             TextField(
              onChanged: (value){
                setState(() {
                  ghjnameController.text = value;
                });
              },
              controller: ghjnameController,
              style: GoogleFonts.inter(
                  fontWeight:FontWeight.w500,
                    color:Colors.black,
                  fontSize:16,
                ),
              textInputAction: TextInputAction.done,
            
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                 fillColor: Color.fromRGBO(255, 255, 255, 1),

                filled: true,
                hintText: 'Your Name',
                hintStyle: GoogleFonts.inter(
                  fontWeight:FontWeight.w500,
                  color:Colors.black,
                  fontSize:16,
                ),
                
              enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)

                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)

                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                   borderSide: BorderSide(color: Colors.transparent)

                ),
                alignLabelWithHint: true,
              ),
            ),
              SizedBox(height: 10),
                Container(height: 142,
            child: TextField(
              
              onChanged: (value){
                setState(() {
                  ghjcommentController.text = value;
                });
              },
              controller: ghjcommentController,
              style: GoogleFonts.inter(
                  fontWeight:FontWeight.w500,
                   color:Colors.black,
                  fontSize:16,
                ),
              textInputAction: TextInputAction.done,
              expands: true,
              maxLines: null,
              minLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                 fillColor: Color.fromRGBO(255, 255, 255, 1),

                filled: true,
                hintText: 'Your Message',
                hintStyle: GoogleFonts.inter(
                  fontWeight:FontWeight.w500,
                  color:Colors.black,
                  fontSize:16,
                ),
                
              enabledBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)

                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)

                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                   borderSide: BorderSide(color: Colors.transparent)

                ),
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
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
               SizedBox(height: 10),

          ],
        )),
    );
  }
}