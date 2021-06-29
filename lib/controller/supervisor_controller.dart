import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../model/supervisor.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class SupervisorController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbz0wByXqQT0eD8nJja9CjTM5q-HGiao_DCapi1JblMv9bPbk6rQQB3xwh8bRaRKkcfc/exec";
      //"https://script.google.com/macros/s/AKfycbz0wByXqQT0eD8nJja9CjTM5q-HGiao_DCapi1JblMv9bPbk6rQQB3xwh8bRaRKkcfc/exec";
      // sheet in novikov's acc "https://script.google.com/macros/s/AKfycbw7zu3J0U0m5MiuGZU4J5cUG4fgQfEb5kkD5-LqRNivn2FbUjwx/exec";


  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      SupervisorCheck supervisorCheck, void Function(String) callback) async {
    try {
      await http.post(URL, body: supervisorCheck.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(url).then((response) {
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
