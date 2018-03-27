import 'package:flutter/material.dart';

class EditTextPage extends StatelessWidget {
  EditTextPage({
    Key key,
    this.title,
    this.initValue,
    this.hintText,
  })
      : _controller = new TextEditingController(
          text: initValue,
        );

  final String title;
  final String initValue;
  final String hintText;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new TextField(
              controller: _controller,
              autofocus: true,
              decoration: new InputDecoration(
                hintText: hintText,
              ),
              onSubmitted: (String newValue) {
                Navigator.of(context).pop(newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
