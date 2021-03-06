import 'package:date_time_picker/date_time_picker.dart';

/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String room;
  String datetime;
  String checkTile;
  String feedback;

  FeedbackForm({this.room,this.checkTile, this.feedback})
      :
    datetime = DateFormat.yMd().format(DateTime.now());

  factory FeedbackForm.fromJson(dynamic json) {
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
