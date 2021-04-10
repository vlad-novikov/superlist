import 'package:date_time_picker/date_time_picker.dart';
import 'dart:convert';

/// FeedbackForm is a data class which stores data fields of Feedback.

class SupervisorCheck {
  String supervisor;
  String datetime = "2020-01-01";
  String feedback;

  static const String Carpet = "Ковер перед дверью";
  static const String Plate = "Табличка с номером";
  static const String Knob = "Дверная ручка";
  static const String Leaf = "Полотно двери";
  static const String DoNotDisturb = "Табличка НЕ БЕСПОКОИТЬ";
  Map door = {
    Carpet: false,
    Plate: false,
    Knob: false,
    Leaf: false,
    DoNotDisturb: false
  };



  //FeedbackForm(this.SupervisorCheck,this.datetime,this.checkTile, this.feedback);
  SupervisorCheck(this.supervisor,this.datetime,this.feedback,door[SupervisorCheck.Carpet],door[Plate],door[Knob],door[Leaf],door[DoNotDisturb]);


  factory SupervisorCheck.fromJson(dynamic json) {

    //var curdatetime = DateFormat.yMd().format(DateTime.now());
    return SupervisorCheck(
        "${json['supervisor']}",
        "${json['datetime']}",
        "${json['feedback']}",
        "${json['doorCarpet']}",
        "${json['doorPlate']}",
        "${json['doorKnob']}",
        "${json['doorLeaf']}",
        "${json['doorDoNotDisturb']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'Supervisor': supervisor,
    'datetime': datetime,
    'feedback': feedback,
    'doorCarpet':door[Carpet],
    'doorPlate':door[Plate],
    'doorKnob':door[Knob],
    'doorLeaf':door[Leaf],
    'doorDoNotDisturb':door[DoNotDisturb],
  };
}

class Door1{
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