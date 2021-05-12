import 'package:date_time_picker/date_time_picker.dart';
import 'dart:convert';

/// FeedbackForm is a data class which stores data fields of Feedback.

class SupervisorCheck {
  String room;
  String datetime = "2020-01-01";
  String feedback;
  // door area elements
  String doorCarpet;
  String doorPlate;
  String doorKnob;
  String doorLeaf;
  String doorDoNotDisturb;
  // passage area elements
  String passageCarpet;
  String passageBaseBoard;
  String passageWalls;
  String passageCeiling;
  // bath area elements
  String bathDoor;
  String bathKnob;
  String bathSink;
  String bathDrain;
  String bathTile;
  // wardrobe area
  String wardrobeShelves;
  String wardrobeLaundryReceipt;
  String wardrobeShoeHorn;
  String wardrobeHangers;
  String wardrobeLuggageRack;
  // LivingRoom area elements
  String livingRoomWalls;
  String livingRoomConditioner;
  String livingRoomCarpet;
  String livingRoomWindow;
  String livingRoomCurtains;
  String livingRoomTv;

  SupervisorCheck(this.room,this.datetime,this.feedback,
      this.doorCarpet,this.doorPlate,this.doorKnob,this.doorLeaf,this.doorDoNotDisturb,
      this.passageBaseBoard,this.passageCarpet,this.passageCeiling,this.passageWalls,
      this.bathDoor,this.bathDrain,this.bathKnob,this.bathSink,this.bathTile,
      this.wardrobeHangers,this.wardrobeLaundryReceipt,this.wardrobeLuggageRack,this.wardrobeShelves,this.wardrobeShoeHorn,
      this.livingRoomCarpet,this.livingRoomConditioner,this.livingRoomCurtains,this.livingRoomTv,this.livingRoomWalls,this.livingRoomWindow);

  factory SupervisorCheck.fromJson(dynamic json) {
    //var curdatetime = DateFormat.yMd().format(DateTime.now());
    return SupervisorCheck(
        "${json['room']}",
        "${json['datetime']}",
        "${json['feedback']}",

        "${json['doorCarpet']}",
        "${json['doorPlate']}",
        "${json['doorKnob']}",
        "${json['doorLeaf']}",
        "${json['doDoNotDisturb']}",

        "${json['passageBaseBoard,']}",
        "${json['passageCarpet']}",
        "${json['passageCeiling,']}",
        "${json['passageWalls']}",

        "${json['bathDoor']}",
        "${json['bathDrain']}",
        "${json['bathKnob']}",
        "${json['bathSink']}",
        "${json['bathTile']}",

        "${json['wardrobeHangers']}",
        "${json['wardrobeLaundryReceipt']}",
        "${json['wardrobeLuggageRack']}",
        "${json['wardrobeShelves']}",
        "${json['wardrobeShoeHorn']}",

        "${json['livingRoomCarpet']}",
        "${json['livingRoomConditioner']}",
        "${json['livingRoomCurtains']}",
        "${json['livingRoomTv']}",
        "${json['livingRoomWalls']}",
        "${json['livingRoomWindow']}"

    );
  }

  // Method to make GET parameters.
  Map toJson() => {
    'room': room,
    'datetime': datetime,
    'feedback': feedback,

    'doorCarpet':doorCarpet,
    'doorPlate':doorPlate,
    'doorKnob':doorKnob,
    'doorLeaf':doorLeaf,
    'doorDoNotDisturb':doorDoNotDisturb,

    'passageCarpet': passageCarpet,
    'passageBaseBoard':passageBaseBoard,
    'passageWalls': passageWalls,
    'passageCeiling': passageCeiling,

    'bathDoor': bathDoor,
    'bathKnob': bathKnob,
    'bathSink': bathSink,
    'bathDrain': bathDrain,
    'bathTile': bathTile,
  
    'wardrobeShelves': wardrobeShelves,
    'wardrobeLaundryReceipt': wardrobeLaundryReceipt,
    'wardrobeShoeHorn': wardrobeShoeHorn,
    'wardrobeHangers': wardrobeHangers,
    'wardrobeLuggageRack': wardrobeLuggageRack,

    'livingRoomWalls': livingRoomWalls,
    'livingRoomConditioner': livingRoomConditioner,
    'livingRoomCarpet': livingRoomCarpet,
    'livingRoomWindow,': livingRoomWindow,
    'livingRoomCurtains': livingRoomCurtains,
    'livingRoomTv': livingRoomTv,

  };
}

