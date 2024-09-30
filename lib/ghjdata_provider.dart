
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ghjDataProvider {


 


 Future<bool> firstTimeVisited()async{
    final bool firstTime =  prefs.getBool('firstTimeVisited') ?? true;
    if(firstTime){
      List<String> hotelsInfo = [];
      for (var i = 6 ; i> 0 ; i--){
        hotelsInfo.add(
         jsonEncode({
          'rate' :0,
          'booked' : false,
          'date' : '',
          'coments' : [
          ],
        }) );
        await prefs.setStringList('hotels',hotelsInfo);
      
      }
      List<String> placesInfo = [];
      for (var i = 3 ; i> 0 ; i--){
        placesInfo.add(
         jsonEncode({
          'rate' :0,
          'coments' : [
          ],
        }) );
        await prefs.setStringList('places',placesInfo);
      
      }

       List<String> factsInfo = [];
      for (var i = 3 ; i> 0 ; i--){
        factsInfo.add(
         jsonEncode({
          'rate' :0,
          'coments' : [
          ],
        }) );
        await prefs.setStringList('facts',factsInfo);
      
      }
       

      
    }
    await(prefs.setBool('firstTimeVisited', false));
    return firstTime;
  }


  final SharedPreferences prefs;

  ghjDataProvider({required this.prefs});
  


}