import 'dart:convert';
import 'package:http/http.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  //Asia/Kolkata

  WorldTime({ this.location, this.flag, this.url });

  Future<void> getTime() async {
    try{
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map timeMap = jsonDecode(response.body);
      String dateTime = timeMap['utc_datetime'];
      String offsetHrs = timeMap['utc_offset'].toString().substring(1,3);
      String offsetMin = timeMap['utc_offset'].toString().substring(4,6);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offsetHrs)));
      now = now.add(Duration(minutes: int.parse(offsetMin)));

      time = now.toString();
    }catch(e){
      print('Error caught $e ');
      time = 'Error while loading time';
    }
  }
}