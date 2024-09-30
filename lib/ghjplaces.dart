

import 'dart:convert';

import 'package:d7/ghjdata.dart';
import 'package:d7/ghjdata_provider.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjselected_hotel.dart';
import 'package:d7/ghjselected_place.dart';
import 'package:d7/ghjsettings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ghjPlacesPage extends StatefulWidget {
  const ghjPlacesPage({super.key});

  @override
  State<ghjPlacesPage> createState() => _ghjPlacesPageState();
}

class _ghjPlacesPageState extends State<ghjPlacesPage> {
  @override
  Widget build(BuildContext context) {
   final List ghjdecodedBody = 
    jsonDecode(getIt.get<ghjDataProvider>()
    .prefs.getStringList('places')!.toString());
    return Scaffold(
      appBar: AppBar(
       
        
         title: Text('Places'),
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
      ),

      body: 
            ListView.builder(
                shrinkWrap: true,
                itemCount: places.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                             CupertinoPageRoute(builder: 
                             (context)=>SelectedPlace(
                              
                             selectedPlaceIndex:   index,
                             ))).then((_)=>setState(() {
                               
                             }));
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                               color: Color.fromRGBO(255, 255, 255, 1),
                              
                            ),
                            child: Column(children: [
                               
                               Container(
                                
                                width: double.infinity,
                                        height: 156,
                                decoration: BoxDecoration(
                                 
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(image:
                                   AssetImage(places[index]['images'][0]),
                                   
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
                                           child: Text(places[index]['title'],
                                                                             
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
                                       Text('${(places[index]['rating'] + (ghjdecodedBody[index]['rate'] / 100)).toStringAsFixed(2)}',
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
                        ),
                      ],
                    ),
                  );
                },),
  
    );
  }
}