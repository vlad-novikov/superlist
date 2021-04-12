import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../model/supervisor.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class SupervisorController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbw7zu3J0U0m5MiuGZU4J5cUG4fgQfEb5kkD5-LqRNivn2FbUjwx/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      SupervisorCheck supervisorCheck, void Function(String) callback) async {
    try {
      print("On submit doorPlate="+supervisorCheck.doorPlate.toString());
      print("On submit JSON="+supervisorCheck.toJson().toString());
      await http.post(URL, body: supervisorCheck.toJson()).then((response) async {
        print("status Code = "+ response.statusCode.toString());
        //print("location = "+ response.headers['location'].toString());
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
            print("after redirect status Code = "+ response.statusCode.toString());
            //print("after redirect status  = "+ convert.jsonDecode(response.body)['status']);
            print("after redirect headers  = "+ response.headers.values.toString());
            print("after redirect body  = "+ convert.jsonDecode(response.body).toString());
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<SupervisorCheck>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => SupervisorCheck.fromJson(json)).toList();
    });
  }
}
