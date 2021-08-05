// v.novikov@okhtinskaya.com
// this is model of roomservice manager's check of room
import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';

import 'controller/technician_controller.dart';
import 'model/technician.dart';
import 'package:google_sheets_app/drawer.dart';

import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

// set defaults

bool _isChecked = false;

// bathroom
bool _toiletDrain = false;
bool _bathDrain = false;
bool _sinkDrain = false;
bool _ventilation = false;
// conditioner
bool _conditionerDrain = false;
bool _conditionerFilter = false;
bool _conditionerCase = false;
bool _conditionerRemote = false;
// window
bool _windowHandle = false;
bool _windowFork = false;
bool _windowNoBlow = false;
bool _windowSlope = false;

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);


class TechnicianScreen extends StatelessWidget {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чек-лист техника',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TechnicianPage(title: 'Чек-лист техника'),
    );
  }
}

class TechnicianPage extends StatefulWidget {
  TechnicianPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TechnicianPageState createState() => _TechnicianPageState();
}

class _TechnicianPageState extends State<TechnicianPage> {
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
  TextEditingController roomController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController datetimeController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState.validate()) {
      // If the form is valid, proceed.
      TechnicianCheck technicianCheck = TechnicianCheck(
          roomController.text,
          nameController.text,
          datetimeController.text,
          feedbackController.text,
          _toiletDrain.toString(),
          _bathDrain.toString(),
          _sinkDrain.toString(),
          _ventilation.toString(),
          _conditionerDrain.toString(),
          _conditionerFilter.toString(),
          _conditionerCase.toString(),
          _conditionerRemote.toString(),
          _windowHandle.toString(),
          _windowFork.toString(),
          _windowNoBlow.toString(),
          _windowSlope.toString()
      );

      TechnicianController technicianController = TechnicianController();

      _showSnackbar("Сохраняю документ");

      // Submit 'technicianCheck' and save it in Google Sheets.
      technicianController.submitForm(technicianCheck, (String response) {
        print("Response: $response");
        if (response == TechnicianController.STATUS_SUCCESS) {
          // Feedback is saved succesfully in Google Sheets.
          _showSnackbar("Документ сохранен");
        } else {
          // Error Occurred while saving data in Google Sheets.
          _showSnackbar("Произошла ошибка! $response");
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
          title: const Text('Общие данные'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content:
          Column(
              children: <Widget>[
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
                  decoration: InputDecoration(labelText: '№ комнаты'),
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Фамилия Имя Отчество';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Фамилия'),
                ),
                TextFormField(
                  controller: feedbackController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(labelText: 'Примечание'),
                ),
              ]
          )

      ),


      new Step(
        title: const Text('Туалет'),
        isActive: true,
        state: StepState.indexed,
        content:
        Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Слив унитаза"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _toiletDrain,
              onChanged: (value) {
                setState(() {
                  _toiletDrain = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Сифон душа"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _bathDrain,
              onChanged: (value) {
                setState(() {
                  _bathDrain = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Сифон в раковине"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _sinkDrain,
              onChanged: (value) {
                setState(() {
                  _sinkDrain = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Вытяжка"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _ventilation,
              onChanged: (value) {
                setState(() {
                  _ventilation = value;
                });
              },
            ),
          ],
        ),
      ),
      new Step(
        title: const Text('Кондиционер'),
        //subtitle: const Text('Subtitle'),
        isActive: true,
        //state: StepState.editing,
        state: StepState.indexed,
        content:
        Column(
          children: <Widget>[
            CheckboxListTile(
              title: Text("Слив"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _conditionerDrain,
              onChanged: (value) {
                setState(() {
                  _conditionerDrain = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Фильтр"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _conditionerFilter,
              onChanged: (value) {
                setState(() {
                  _conditionerFilter = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Корпус"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _conditionerCase,
              onChanged: (value) {
                setState(() {
                  _conditionerCase = value;
                });
              },
            ),
            CheckboxListTile(
              title: Text("Пульт"),
              controlAffinity: ListTileControlAffinity.leading,
              value: _conditionerRemote,
              onChanged: (value) {
                setState(() {
                  _conditionerRemote = value;
                });
              },
            ),
          ],
        ),

      ),
      new Step(
          title: const Text('Окно'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content:
          Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text("Ручки"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _windowHandle,
                  onChanged: (value) {
                    setState(() {
                      _windowHandle = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Вилки"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _windowFork,
                  onChanged: (value) {
                    setState(() {
                      _windowFork = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Не дует"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _windowNoBlow,
                  onChanged: (value) {
                    setState(() {
                      _windowNoBlow = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Откосы"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _windowSlope,
                  onChanged: (value) {
                    setState(() {
                      _windowSlope = value;
                    });
                  },
                ),

              ]
          )

      ),

    ];

    return Scaffold(
      key: _scaffoldKey,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: DefaultDrawer(),
      body:  SingleChildScrollView(
        //child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                                physics : ClampingScrollPhysics(),
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
                                controlsBuilder:
                                    (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                                  return Row(
                                    children: <Widget>[
                                      /* FlatButton(
                                      onPressed: onStepContinue,
                                      child: const Text('Далее'),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      ), */
                                      /*FlatButton(
                                      onPressed: onStepCancel,
                                      child: const Text('Отмена'),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      ),*/
                                    ],
                                  );
                                }
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
          ],
        ),
        //),
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
