import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Function onChange;
  const TextFieldContainer({
    Key key,
    this.textController,
    this.labelText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
          controller: textController,
          onChanged: onChange,
          decoration: InputDecoration(
              fillColor: Colors.grey,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'information not provided';
            }
            return null;
          }),
    );
  }
}

class NumberTextFieldContainer extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Function onChange;
  const NumberTextFieldContainer({
    Key key,
    this.textController,
    this.labelText,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: TextFormField(
          onChanged: onChange,
          controller: textController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              fillColor: Colors.grey,
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.blueAccent))),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'information not provided';
            }
            return null;
          }),
    );
  }
}
