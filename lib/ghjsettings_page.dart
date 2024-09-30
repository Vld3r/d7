



import 'package:d7/ghjapp_theme.dart';
import 'package:d7/ghjfeed_back.dart';
import 'package:d7/ghjlink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
  
    final Uri ghjurl1 = Uri.parse(myPolicyAppuIA);
    final Uri ghjurl2 = Uri.parse(myTermsAppuIA);
    return Scaffold(
      appBar: AppBar(
      
      
        centerTitle: false,
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
        
      
        title: Text('Settings',),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [  
          GestureDetector(
              onTap: ()async{
                   final InAppReview 
                   inAppReview = InAppReview.instance;

                    if (await inAppReview.isAvailable()) {
                      inAppReview.requestReview();
                    }

                  },
            child: Container(
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(255, 255, 255, 1)
              ),
          
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rate App')
                  ]
                  
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
           GestureDetector(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: 
              (context)=>ghjFeedBackPage()));
            },
             child: Container(
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(255, 255, 255, 1)
              ),
           
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(children: [
                
                        Text('Contact Us')
                    ],),
                
                  
                  ]
                  
                  ),
                ),
              ),
                     ),
           ),
          SizedBox(height: 10,),

           GestureDetector
           (
            onTap: ()async{
                 if (!await launchUrl(ghjurl2)) {
                  
                    }
            },
             child: Container(
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color:Color.fromRGBO(255, 255, 255, 1)
              ),
           
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                 
                  children: [
                    Text('Terms of Service')
                  ],
                  
                  ),
                ),
              ),),
           ),
            SizedBox(height: 10,),

           GestureDetector(
            onTap: ()async{
                 if (!await launchUrl(ghjurl1)) {
                     
                    }
            },
             child: Container(
              height: 59,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromRGBO(255, 255, 255, 1)
              ),
           
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                   
                    children: [
                      
                
                   
                   Text('Privacy Policy')
                  ]
                  
                  ),
                ),
              ),),
           ), SizedBox(height: 10,),

          
        ]),
      ),
    );
  }
}