import 'package:date_time_picker/date_time_picker.dart';
import 'dart:convert';

/// FeedbackForm is a data class which stores data fields of Feedback.

class SupervisorCheck {
  String Supervisor;
  String datetime = "2020-01-01";
  String feedback;

  String doorCarpet;
  String doorKnob;


  //FeedbackForm(this.SupervisorCheck,this.datetime,this.checkTile, this.feedback);
  SupervisorCheck(this.Supervisor,this.datetime,this.feedback,
      this.doorCarpet,this.doorKnob);


  factory SupervisorCheck.fromJson(dynamic json) {

    //var curdatetime = DateFormat.yMd().format(DateTime.now());
    return SupervisorCheck(
        "${json['Supervisor']}",
        "${json['datetime']}",
        "${json['feedback']}",
        "${json['doorCarpet']}",
        "${json['doorKnob']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'Supervisor': Supervisor,
    'datetime': datetime,
    'feedback': feedback,
    'doorCarpet':doorCarpet.toString(),
    'doorKnob':doorKnob
  };
}

class Door{
  bool Carpet = false;
  String Plate;
  String Knob;
  String Leaf;
  String DoNotDisturb;
}

class Passage{
  String Carpet;
  String BaseBoard;
  String Walls;
  String Ceiling;
}

class Bathroom {
  String Door;
  String Knob;
  String Sink;
  String Drain;
  String Tile;
}

class Wardrobe {
  String Shelves;
  String LaundryReceipt;
  String ShoeHorn;
  String Hangers;
  String LuggageRack;
}

class LivingRoom {

  String Walls;
  String Conditioner;
  String Carpet;
  String Windows;
  String Curtains;
  String Tv;
}