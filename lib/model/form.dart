/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String name;
  String room;
  String datetime;
  String mobileNo;
  String feedback;

  FeedbackForm(this.name, this.room,this.datetime, this.mobileNo, this.feedback);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['name']}",
        "${json['room']}",
        "${json['datetime']}",
        "${json['mobileNo']}",
        "${json['feedback']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'room': room,
        'datetime': datetime,
        'mobileNo': mobileNo,
        'feedback': feedback
      };
}
