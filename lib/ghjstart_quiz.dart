
import 'package:d7/ghjapp_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Map<String,dynamic>> ghjquest =[
{ 
   'question' : 'Which of the following is a\npopular activity at Niagara\nFalls Resort?',
   'image' : 'assets/que/1.png',

    'answers': [
      {
        'answer' : "Zip Lining",
        'correct' : false,
      },
       {
        'answer' : "Whale Watching",
        'correct' : false,
      },
       {
        'answer' : "Wine Tasting",
        'correct' : true,
      },
       {
        'answer' : "Hot Air Ballooning",
        'correct' : false,
      },

    ]

},

    { 
   'question' : 'What is the name of the\ntallest waterfall at Niagara\nFalls?',
 'image' : 'assets/que/2.png',
    'answers': [
      {
        'answer' : "Bridal Veil Falls",
        'correct' : false,
      },
       {
        'answer' : "American Falls",
        'correct' : false,
      },
       {
        'answer' : "Angel Falls",
        'correct' : false,
      },
       {
        'answer' : "Horseshoe Falls",
        'correct' : true,
      },

    ]

},
 { 
   'question' : 'Which nearby attraction\noffers panoramic views of\nNiagara Falls?',
 'image' : 'assets/que/3.png',
    'answers': [
      {
        'answer' : "Clifton Hill",
        'correct' : false,
      },
       {
        'answer' : "Skylon Tower",
        'correct' : true,
      },
       {
        'answer' : "Niagara Casino",
        'correct' : false,
      },
       {
        'answer' : "Whirlpool Aero Car",
        'correct' : false,
      },

    ]

},
{ 
   'question' : 'Which facility is included in\nmany Niagara Falls Resorts\nfor relaxation?',
 'image' : 'assets/que/4.png',
    'answers': [
      {
        'answer' : "Tennis Court",
        'correct' : false,
      },
       {
        'answer' : "Indoor Pool",
        'correct' : true,
      },
       {
        'answer' : "Ice Skating Rink",
        'correct' : false,
      },
       {
        'answer' : "Bowling Alley",
        'correct' : false,
      },

    ]

},
{ 
   'question' : 'How many waterfalls make\nup Niagara Falls?',
 'image' : 'assets/que/5.png',
    'answers': [
      {
        'answer' : "3",
        'correct' : true,
      },
       {
        'answer' : "2",
        'correct' : false,
      },
       {
        'answer' : "4",
        'correct' : false,
      },
       {
        'answer' : "5",
        'correct' : false,
      },

    ]

},
{ 

   'question' : 'What river flows over Niagara Falls?',
 'image' : 'assets/que/6.png',
    'answers': [
      {
        'answer' : "Hudson River",
        'correct' : false,
      },
       {
        'answer' : "Niagara River",
        'correct' : true,
      },
       {
        'answer' : "Mississippi River",
        'correct' : false,
      },
       {
        'answer' : "Ohio River",
        'correct' : false,
      },

    ]

},
{ 
   'question' : 'Which of these hotels offers a view of both the American and Canadian Falls?',
 'image' : 'assets/que/7.png',
    'answers': [
      {
        'answer' : "Crowne Plaza",
        'correct' : false,
      },
       {
        'answer' : "The Beverly Hills Hotel",
        'correct' : true,
      },
       {
        'answer' : "Hilton Niagara Falls",
        'correct' : false,
      },
       {
        'answer' : "Comfort Inn",
        'correct' : false,
      },

    ]

}
,
{ 
   'question' : 'Which Niagara Falls activity involves getting up close to the Falls on a boat?',
 'image' : 'assets/que/8.png',
    'answers': [
      {
        'answer' : "Niagara City Cruises",
        'correct' : true,
      },
       {
        'answer' : "Niagara SkyWheel",
        'correct' : false,
      },
       {
        'answer' : "Niagara SkyWheel",
        'correct' : false,
      },
       {
        'answer' : "Whirlpool Jet Boat Tours",
        'correct' : false,
      },

    ]

},

{ 
   'question' : 'Which month is Niagara Falls most frequently illuminated by colorful lights?',
 'image' : 'assets/que/9.png',
    'answers': [
      {
        'answer' : "July",
        'correct' : false,
      },
       {
        'answer' : "December",
        'correct' : true,
      },
       {
        'answer' : "May",
        'correct' : false,
      },
       {
        'answer' : "September",
        'correct' : false,
      },

    ]

}
,{ 
   'question' : 'What country is on the other side of Niagara Falls from Canada?',
 'image' : 'assets/que/10.png',
    'answers': [
      {
        'answer' : "Mexico",
        'correct' : false,
      },
       {
        'answer' : "United States",
        'correct' : true,
      },
       {
        'answer' : "France",
        'correct' : false,
      },
       {
        'answer' : "United Kingdom",
        'correct' : false,
      },

    ]

}

];
class StartedQuiz extends StatefulWidget {
  const StartedQuiz({super.key});

  @override
  State<StartedQuiz> createState() => _StartedQuizState();
}

class _StartedQuizState extends State<StartedQuiz> {

  int ghjcurrentIndex = 0;
  int ghjcorrectAnswered = 0;
  

  @override
  Widget build(BuildContext context) {
    
     double ghjwidth = MediaQuery.sizeOf(context).width;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(

          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(232, 97, 188, 1),
            Color.fromRGBO(248, 150, 25, 1)
          ])
      ),
      child: Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.transparent,
         leadingWidth: 126,
       leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
              onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, color:
                 Colors.white),
                
                Text(
              'Back',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color:    Colors.white,
              ),
            ),
              ],
            ),
          ),
        ),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            
            
              
              children: [
                Image.asset(ghjquest[ghjcurrentIndex]['image'],
                  fit: BoxFit.fill,
                ),
             ghjwidth >= 700 ?   SizedBox(height: 50,) : SizedBox.shrink(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            ghjquest[ghjcurrentIndex]['question'],
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                     
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (ghjquest[ghjcurrentIndex]['answers'][index]['correct']) {
                            ghjcorrectAnswered += 1;
                          }
                          if (ghjcurrentIndex != 9) {
                            setState(() {
                              ghjcurrentIndex += 1;
                            });
                          } else {
                            _ghjshowResultDialog(context);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            ghjquest[ghjcurrentIndex]['answers'][index]['answer'],
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Questions : ${ghjcurrentIndex+1} / 10',style: GoogleFonts.inter(fontWeight: 
                    FontWeight.w700,fontSize: 16),),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  void _ghjshowResultDialog(BuildContext context) {
    String resultMessage = ghjcorrectAnswered == 10 ? 'You win' : 'You Lose';
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  resultMessage,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
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
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}