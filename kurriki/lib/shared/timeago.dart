
import 'package:intl/intl.dart';

String timeAgo(datetime) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    // var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

   var date = DateTime.parse(datetime);
    var diff = now.difference(date);
    print(date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString());
    print(diff.inDays);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes < 1 && diff.inHours == 0 && diff.inDays == 0) {
      time = format.format(date);
    }else if(diff.inMinutes > 0   && diff.inMinutes < 60 ){
      if (diff.inMinutes == 1) {
        time = diff.inMinutes.toString() + ' MINUTE AGO';
      } else {
        time = diff.inMinutes.toString() + ' MINUTES AGO';
      }
    
    }else if(diff.inHours > 0 ){
       if (diff.inHours == 1) {
        time = diff.inHours.toString() + ' HOUR AGO';
      } else {
        time = diff.inHours.toString() + ' HOURS AGO';
      }
    }
     else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }



String timeAgoMessage(datetime) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    // var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

   var date = DateTime.parse(datetime);
    var diff = now.difference(date);
    // print("diff.inSeconds");
    // print(diff.inDays);
    var time = '';
    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes < 1 && diff.inHours == 0 && diff.inDays == 0) {
      time = format.format(date);
    }else if(diff.inMinutes > 0   && diff.inMinutes < 60 ){
      if (diff.inMinutes == 1) {
        time = diff.inMinutes.toString() + ' MINUTE AGO';
      } else {
        time = diff.inMinutes.toString() + ' MINUTES AGO';
      }
    
    }else if(diff.inHours > 0  && diff.inHours <= 24){
       if (diff.inHours == 1) {
        time = diff.inHours.toString() + ' HOUR AGO';
      } else {
        time = diff.inHours.toString() + ' HOURS AGO';
      }
    }else {
      time = date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString();
    }

    return time;
  }

  String timeAgoDate(datetime) {
   var date = DateTime.parse(datetime);
   return date.day.toString() + "-" + date.month.toString() + "-" + date.year.toString();
  }