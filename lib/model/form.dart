import 'package:date_time_picker/date_time_picker.dart';

/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String room;
  String datetime = "2020-01-01";
  String checkTile;
  String feedback;


  //FeedbackForm(this.room,this.datetime,this.checkTile, this.feedback);
  FeedbackForm(this.room,this.datetime,this.checkTile, this.feedback);


  factory FeedbackForm.fromJson(dynamic json) {

    //var curdatetime = DateFormat.yMd().format(DateTime.now());
    return FeedbackForm(
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
