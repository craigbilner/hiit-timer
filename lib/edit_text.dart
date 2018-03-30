import 'package:flutter/material.dart';

class EditTextPage extends StatefulWidget {
  EditTextPage({
    Key key,
    this.title,
    this.initValue,
    this.hintText,
  });

  final String title;
  final String initValue;
  final String hintText;

  @override
  _EditTextPageState createState() => new _EditTextPageState();
}

class _EditTextPageState extends State<EditTextPage> {
  TextEditingController _controller;

  @override
  initState() {
    super.initState();

    _controller = new TextEditingController(
      text: widget.initValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Center(
          child: new Text(widget.title),
        ),
      ),
      body: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new TextField(
            controller: _controller,
            autofocus: true,
            decoration: new InputDecoration(
              hintText: widget.hintText,
            ),
            onSubmitted: (String newValue) {
              Navigator.of(context).pop(newValue);
            },
          ),
        ),
      ),
    );
  }
}
