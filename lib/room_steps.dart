import 'package:flutter/material.dart';
//import 'package:validate/validate.dart';  //for validation

List<Step> steps = [
  new Step(
      title: const Text('Name'),
      //subtitle: const Text('Enter your name'),
      isActive: true,
      //state: StepState.error,
      state: StepState.indexed,
      content: new TextFormField(
        focusNode: _focusNode,
        keyboardType: TextInputType.text,
        autocorrect: false,
        onSaved: (String value) {
          data.name = value;
        },
        maxLines: 1,
        //initialValue: 'Aseem Wangoo',
        validator: (value) {
          if (value.isEmpty || value.length < 1) {
            return 'Please enter name';
          }
        },
        decoration: new InputDecoration(
            labelText: 'Enter your name',
            hintText: 'Enter a name',
            //filled: true,
            icon: const Icon(Icons.person),
            labelStyle:
            new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      )),
  new Step(
      title: const Text('Phone'),
      //subtitle: const Text('Subtitle'),
      isActive: true,
      //state: StepState.editing,
      state: StepState.indexed,
      content: new TextFormField(
        keyboardType: TextInputType.phone,
        autocorrect: false,
        validator: (value) {
          if (value.isEmpty || value.length < 10) {
            return 'Please enter valid number';
          }
        },
        onSaved: (String value) {
          data.phone = value;
        },
        maxLines: 1,
        decoration: new InputDecoration(
            labelText: 'Enter your number',
            hintText: 'Enter a number',
            icon: const Icon(Icons.phone),
            labelStyle:
            new TextStyle(decorationStyle: TextDecorationStyle.solid)),
      )),
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
          data.email = value;
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
          data.age = value;
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