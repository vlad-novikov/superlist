import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';

import 'controller/form_controller.dart';
import 'model/form.dart';

import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Заявки супервайзеров',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Заявки супервайзеров'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      FeedbackForm feedbackForm = FeedbackForm(
          nameController.text,
          roomController.text,
          datetimeController.text,
          mobileNoController.text,
          feedbackController.text);

      FormController formController = FormController();

      _showSnackbar("Сохраняю заявку");

      // Submit 'feedbackForm' and save it in Google Sheets.
      formController.submitForm(feedbackForm, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Заявка сохранена");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Произошла ошибка!");
        }
      });
    }
  }

  // Method to show snackbar with 'message'.
  _showSnackbar(String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите Имя';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Имя'),
                      ),
                      TextFormField(
                        controller: roomController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите номер комнаты';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        decoration: InputDecoration(labelText: 'Комната'),
                      ),
                      TextFormField(
                        controller: datetimeController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите дату';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(labelText: 'Дата и Время'),
                      ),

                      TextFormField(
                        controller: mobileNoController,
                        validator: (value) {
                          //if (value.trim().length != 10) {
                          //  return 'Enter 10 Digit Mobile Number';
                          //}
                          return null;
                        },

                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],


                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Телефон',
                        ),
                      ),
                      TextFormField(
                        controller: feedbackController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Введите описание';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Описание'),
                      ),
                    ],
                  ),
                )),
            RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: _submitForm,
              child: Text('Сохранить'),
            ),
            RaisedButton(
              color: Colors.lightBlueAccent,
              textColor: Colors.black,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeedbackListScreen(),
                    ));
              },
              child: Text('Просмотреть'),
            ),
          ],
        ),
      ),
    );
  }
}
