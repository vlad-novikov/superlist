//import 'package:date_time_picker/date_time_picker.dart';
//import 'dart:convert';

/// FeedbackForm is a data class which stores data fields of Feedback.

class TechnicianCheck {
  String room;
  String name;
  String datetime = "2020-01-01";
  String feedback;
  // Bathroom
  String toiletDrain;
  String bathDrain;
  String sinkDrain;
  String ventilation;
  // Conditioner
  String conditionerDrain;
  String conditionerFilter;
  String conditionerCase;
  String conditionerRemote;
  // Window
  String windowHandle;
  String windowFork;
  String windowNoBlow;
  String windowSlope;


  TechnicianCheck(this.room,this.name,this.datetime,this.feedback,
  this.toiletDrain,
  this.bathDrain,
  this.sinkDrain,
  this.ventilation,
  this.conditionerDrain,
  this.conditionerFilter,
  this.conditionerCase,
  this.conditionerRemote,
  this.windowHandle,
  this.windowFork,
  this.windowNoBlow,
  this.windowSlope);

  factory TechnicianCheck.fromJson(dynamic json) {
    //var curDateTime = DateFormat.yMd().format(DateTime.now());
    return TechnicianCheck(
        "${json['room']}",
        "${json['name']}",
        "${json['datetime']}",
        "${json['feedback']}",

        "${json['toiletDrain']}",
        "${json['bathDrain']}",
        "${json['sinkDrain']}",
        "${json['ventilation']}",
        "${json['conditionerDrain']}",
        "${json['conditionerFilter']}",
        "${json['conditionerCase']}",
        "${json['conditionerRemote']}",
        "${json['windowHandle']}",
        "${json['windowFork']}",
        "${json['windowNoBlow']}",
        "${json['windowSlope']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'room': room,
    'name': name,
    'datetime': datetime,
    'feedback': feedback,
    // bathroom
    'toiletDrain' : toiletDrain,
    'bathDrain' : bathDrain,
    'sinkDrain' : sinkDrain,
    'ventilation' : ventilation,

    // Conditioner
    'conditionerDrain' : conditionerDrain,
    'conditionerFilter' : conditionerFilter,
    'conditionerCase' : conditionerCase,
    'conditionerRemote' : conditionerRemote,


    // Window
    'windowHandle' : windowHandle,
    'windowFork' : windowFork,
    'windowNoBlow' : windowNoBlow,
    'windowSlope' : windowSlope,
  };
}

