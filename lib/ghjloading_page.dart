
import 'dart:async';

import 'package:d7/ghjdata_provider.dart';
import 'package:d7/main.dart';
import 'package:d7/ghjmain_page.dart';
import 'package:d7/ghjonboarding_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ghjLoadingPage extends StatefulWidget {
  const ghjLoadingPage({super.key});

  @override
  State<ghjLoadingPage> createState() => _ghjLoadingPageState();
}

class _ghjLoadingPageState extends State<ghjLoadingPage>with TickerProviderStateMixin {
  late final AnimationController _ghjncontroller;

  @override
  void initState() {
    super.initState();

    _ghjncontroller = AnimationController(vsync: this);

    Timer(const Duration(seconds: 2), () async{
      bool firstTime = await getIt.get<ghjDataProvider>()
          .firstTimeVisited();
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) =>
            firstTime ? const OnBoardingPage() : const ghjMainPage()
        ),
      );
    });
  }

  @override
  void dispose() {
    _ghjncontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
        floatingActionButtonLocation:
         FloatingActionButtonLocation.endFloat,
     
      backgroundColor: const Color.fromRGBO(36, 66, 139, 1),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Image.asset('assets/logo.png'),

          Column(
            children: [
           
              Image.asset('assets/loading.gif',width: 60,height: 60,),
              const SizedBox(height: 30,),
              Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                      
              children: [
                Text('Terms of Service',style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(255, 232, 58, 1)
                ),),
                const SizedBox(width: 10,),
                const VerticalDivider(
                  thickness: 1,
                  color: Color.fromRGBO(255, 255, 255, 0.24)),
                 const SizedBox(width: 10,),
                Text('Privacy Policy',style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color.fromRGBO(255, 232, 58, 1)
                ),)
              ],
                      ),
            ),
          ),
            ],
          ),
          
          
          ],
        ),
      ),
    );

  }
}

