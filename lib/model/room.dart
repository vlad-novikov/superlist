import 'package:date_time_picker/date_time_picker.dart';

/// FeedbackForm is a data class which stores data fields of Feedback.
class RoomForm {
  String room;
  String datetime = "2020-01-01";
  String checkTile;
  String feedback;


  //FeedbackForm(this.room,this.datetime,this.checkTile, this.feedback);
  RoomForm(this.room,this.datetime,this.checkTile, this.feedback);


  factory RoomForm.fromJson(dynamic json) {

    //var curdatetime = DateFormat.yMd().format(DateTime.now());
    return RoomForm(
        "${json['room']}",
        "${json['datetime']}",
        "${json['checkTile']}",
        "${json['feedback']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'room': room,
        'datetime': datetime,
        'checkTile': checkTile,
        'feedback': feedback
      };
}
