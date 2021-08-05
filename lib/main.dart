// v.novikov@okhtinskaya.com
// this is model of roomservice manager's check of room
import 'package:flutter/material.dart';
import 'package:google_sheets_app/feedback_list.dart';

import 'controller/supervisor_controller.dart';
import 'model/supervisor.dart';
import 'package:google_sheets_app/drawer.dart';

import 'package:flutter/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';

// set defaults

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

void main() => runApp(SupervisorScreen());

class SupervisorScreen extends StatelessWidget {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Чек-лист супервайзера',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SupervisorPage(title: 'Чек-лист супервайзера'),
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
      SupervisorCheck supervisorCheck = SupervisorCheck(
          roomController.text,
          nameController.text,
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
       _wardrobeHangers.toString(),
       _wardrobeShelves.toString(),
       _wardrobeLaundryReceipt.toString(),
       _wardrobeShoeHorn.toString(),
       _wardrobeLuggageRack.toString(),
// LivingRoom area elements
       _livingRoomWalls.toString(),
       _livingRoomConditioner.toString(),
       _livingRoomCarpet.toString(),
       _livingRoomTv.toString(),
       _livingRoomCurtains.toString(),
       _livingRoomWindow.toString()
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
        title: const Text('Входная дверь'),
        //subtitle: const Text('Enter your name'),
        isActive: true,
        //state: StepState.error,
        state: StepState.indexed,
        content:
          Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Ковёр"),
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
              CheckboxListTile(
                title: Text("Дверная ручка"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorKnob,
                onChanged: (value) {
                  setState(() {
                    _doorKnob = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Дверное полотно"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorLeaf,
                onChanged: (value) {
                  setState(() {
                    _doorLeaf = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Табличка Не Беспокоить"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _doorDoNotDisturb,
                onChanged: (value) {
                  setState(() {
                    _doorDoNotDisturb = value;
                  });
                },
              ),
              ],
          ),
      ),
      new Step(
          title: const Text('Прихожая'),
          //subtitle: const Text('Subtitle'),
          isActive: true,
          //state: StepState.editing,
          state: StepState.indexed,
          content:
          Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Ковёр"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _passageCarpet,
                onChanged: (value) {
                  setState(() {
                    _passageCarpet = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Плинтус"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _passageBaseBoard,
                onChanged: (value) {
                  setState(() {
                    _passageBaseBoard = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Стены"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _passageWalls,
                onChanged: (value) {
                  setState(() {
                    _passageWalls = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Потолок"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _passageCeiling,
                onChanged: (value) {
                  setState(() {
                    _passageCeiling = value;
                  });
                },
              ),
            ],
          ),

      ),
      new Step(
          title: const Text('Ванная'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          // state: StepState.disabled,
          content:
            Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text("Дверь"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _bathDoor,
                  onChanged: (value) {
                    setState(() {
                      _bathDoor = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Дверная ручка"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _bathKnob,
                  onChanged: (value) {
                    setState(() {
                      _bathKnob = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Раковина"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _bathSink,
                  onChanged: (value) {
                    setState(() {
                      _bathSink = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Слив"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _bathDrain,
                  onChanged: (value) {
                    setState(() {
                      _bathDrain = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Плитка"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _bathTile,
                  onChanged: (value) {
                    setState(() {
                      _bathTile = value;
                    });
                  },
                ),
              ]
            )

      ),
      new Step(
          title: const Text('Гардероб'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          content:
          Column(
            children: <Widget>[
              CheckboxListTile(
                title: Text("Вешалки"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _wardrobeHangers,
                onChanged: (value) {
                  setState(() {
                    _wardrobeHangers = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Квитанция прачечной"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _wardrobeLaundryReceipt,
                onChanged: (value) {
                  setState(() {
                    _wardrobeLaundryReceipt = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Рожок"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _wardrobeShoeHorn,
                onChanged: (value) {
                  setState(() {
                    _wardrobeShoeHorn = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Полки"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _wardrobeShelves,
                onChanged: (value) {
                  setState(() {
                    _wardrobeShelves = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Багажная ниша"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _wardrobeLuggageRack,
                onChanged: (value) {
                  setState(() {
                    _wardrobeLuggageRack = value;
                  });
                },
              ),
            ]
          )
    ),
      new Step(
          title: const Text('Жилая комната'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: StepState.indexed,
          content:
          Column(
              children: <Widget>[
                CheckboxListTile(
                  title: Text("Ковёр"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomCarpet,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomCarpet = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Кондиционер"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomConditioner,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomConditioner = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Телевизор"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomTv,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomTv = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Стены"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomWalls,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomWalls = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Занавески"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomCurtains,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomCurtains = value;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text("Окно"),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _livingRoomWindow,
                  onChanged: (value) {
                    setState(() {
                      _livingRoomWindow = value;
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
            /*RaisedButton(
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
            ),*/
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
