// v.novikov@okhtinskaya.com
import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';

import 'controller/supervisor_controller.dart';
import 'model/supervisor.dart';
import 'package:google_sheets_app/drawer.dart';

import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

bool _isChecked = false;

// door area elements
bool _doorCarpet = false;
bool _doorPlate = false;
bool _doorKnob = false;
bool _doorLeaf = false;
bool _doorDoNotDisturb = false;
// passage area elements
bool _passageCarpet = false;
bool _passageBaseBoard = false;
bool _passageWalls = false;
bool _passageCeiling = false;
// bath area elements
bool _bathDoor = false;
bool _bathKnob = false;
bool _bathSink = false;
bool _bathDrain = false;
bool _bathTile = false;
// wardrobe area
bool _wardrobeShelves = false;
bool _wardrobeLaundryReceipt = false;
bool _wardrobeShoeHorn = false;
bool _wardrobeHangers = false;
bool _wardrobeLuggageRack = false;
// LivingRoom area elements
bool _livingRoomWalls = false;
bool _livingRoomConditioner = false;
bool _livingRoomCarpet = false;
bool _livingRoomWindow = false;
bool _livingRoomCurtains = false;
bool _livingRoomTv = false;

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

void supervisor_screen() => runApp(SupervisorScreen());

class SupervisorScreen extends StatelessWidget {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чек-лист номеров',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SupervisorPage(title: 'Чек-лист номеров'),
    );
  }
}

class SupervisorPage extends StatefulWidget {
  SupervisorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SupervisorPageState createState() => _SupervisorPageState();
}

class _SupervisorPageState extends State<SupervisorPage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // set stepper
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  static var _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      SupervisorCheck supervisorCheck = SupervisorCheck(
          roomController.text,
          datetimeController.text,
          feedbackController.text,
          _doorCarpet.toString(),
          _doorPlate.toString(),
        _doorKnob.toString(),
       _doorLeaf.toString(),
       _doorDoNotDisturb.toString(),
// passage area elements
       _passageCarpet.toString(),
       _passageBaseBoard.toString(),
       _passageWalls.toString(),
       _passageCeiling.toString(),
// bath area elements
       _bathDoor.toString(),
       _bathKnob.toString(),
       _bathSink.toString(),
       _bathDrain.toString(),
       _bathTile.toString(),
// wardrobe area
       _wardrobeShelves.toString(),
       _wardrobeLaundryReceipt.toString(),
       _wardrobeShoeHorn.toString(),
       _wardrobeHangers.toString(),
       _wardrobeLuggageRack.toString(),
// LivingRoom area elements
       _livingRoomWalls.toString(),
       _livingRoomConditioner.toString(),
       _livingRoomCarpet.toString(),
       _livingRoomWindow.toString(),
       _livingRoomCurtains.toString(),
       _livingRoomTv.toString()
      );

      SupervisorController supervisorController = SupervisorController();

      _showSnackbar("Сохраняю документ");

      // Submit 'SupervisorCheck' and save it in Google Sheets.
      supervisorController.submitForm(supervisorCheck, (String response) {
        print("Response: $response");
        if (response == SupervisorController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Документ сохранен");
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
    List<Step> steps = [
      new Step(
        title: const Text('Входная дверь'),
        //subtitle: const Text('Enter your name'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content:
          Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Ковёр перед дверью"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorCarpet,
                onChanged: (value) {
                  setState(() {
                  _doorCarpet = value;
                    });
                },
              ),
              CheckboxListTile(
                title: Text("Табличка с номером"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorPlate,
                onChanged: (value) {
                  setState(() {
                    _doorPlate = value;
                  });
                },
              ),

              ],
          ),
      ),
      new Step(
          title: const Text('Коридор'),
          //subtitle: const Text('Subtitle'),
          isActive: true,
          //state: StepState.editing,
          state: StepState.indexed,
          content:
          Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Ковёр перед дверью"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorCarpet,
                onChanged: (value) {
                  setState(() {
                    _doorCarpet = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Плинтус в порядке"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _passageBaseBoard,
                onChanged: (value) {
                  setState(() {
                    _passageBaseBoard = value;
                  });
                },
              ),

            ],
          ),

      ),
      new Step(
          title: const Text('Email'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content: new TextFormField(
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Please enter valid email';
              }
            },
            onSaved: (String value) {
              //data.email = value;
            },
            maxLines: 1,
            decoration: new InputDecoration(
                labelText: 'Enter your email',
                hintText: 'Enter a email address',
                icon: const Icon(Icons.email),
                labelStyle:
                    new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      new Step(
          title: const Text('Age'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          content: new TextFormField(
            keyboardType: TextInputType.number,
            autocorrect: false,
            validator: (value) {
              if (value.isEmpty || value.length > 2) {
                return 'Please enter valid age';
              }
            },
            maxLines: 1,
            onSaved: (String value) {
              //data.age = value;
            },
            decoration: new InputDecoration(
                labelText: 'Enter your age',
                hintText: 'Enter age',
                icon: const Icon(Icons.explicit),
                labelStyle:
                    new TextStyle(decorationStyle: TextDecorationStyle.solid)),
          )),
      // new Step(
      //     title: const Text('Fifth Step'),
      //     subtitle: const Text('Subtitle'),
      //     isActive: true,
      //     state: StepState.complete,
      //     content: const Text('Enjoy Step Fifth'))
    ];

    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DefaultDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            new Stepper(
                              steps: steps,
                              type: StepperType.vertical,
                              currentStep: this._currentStep,
                              onStepContinue: () {
                                setState(() {
                                  if (_currentStep < steps.length - 1) {
                                    _currentStep = _currentStep + 1;
                                  } else {
                                    _currentStep = 0;
                                  }
                                  // else {
                                  // Scaffold
                                  //     .of(context)
                                  //     .showSnackBar(new SnackBar(content: new Text('$_currentStep')));

                                  // if (_currentStep == 1) {
                                  //   print('First Step');
                                  //   print('object' + FocusScope.of(context).toStringDeep());
                                  // }

                                  // }
                                });
                              },
                              onStepCancel: () {
                                setState(() {
                                  if (_currentStep > 0) {
                                    _currentStep = _currentStep - 1;
                                  } else {
                                    _currentStep = 0;
                                  }
                                });
                              },
                              onStepTapped: (step) {
                                setState(() {
                                  _currentStep = step;
                                });
                              },
                            )
                          ])
                    ],
                  ),
                )),
            //FractionallySizedBox(heightFactor: 1, widthFactor: 0.95,
            //child: Container(color: Colors.orange)),
            FlatButton(
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
              child: Text('Просмотр'),
            ),
          ],
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
