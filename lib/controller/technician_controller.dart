import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../model/technician.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class TechnicianController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbwC4o0kpJHod5bNlZsJ32YhxRwp--pUAjzfy0t1fRvHEwxAzPiqNGZPAhTtxtXiqzel/exec";
      //"https://script.google.com/macros/s/AKfycbz0wByXqQT0eD8nJja9CjTM5q-HGiao_DCapi1JblMv9bPbk6rQQB3xwh8bRaRKkcfc/exec";
      // sheet in novikov's acc "https://script.google.com/macros/s/AKfycbw7zu3J0U0m5MiuGZU4J5cUG4fgQfEb5kkD5-LqRNivn2FbUjwx/exec";


  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(
      TechnicianCheck technicianCheck, void Function(String) callback) async {
    try {
      await http.post(URL, body: technicianCheck.toJson()).then((response) async {
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
  Future<List<TechnicianCheck>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => TechnicianCheck.fromJson(json)).toList();
    });
  }
}
