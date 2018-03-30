import 'package:flutter/material.dart';
import 'models.dart';
import 'app_bar.dart';

class CreateEditWorkSetsPage extends StatefulWidget {
  CreateEditWorkSetsPage({
    Key key,
    this.workSets,
  });

  final List<WorkSet> workSets;

  @override
  _CreateEditWorkSetsPageState createState() =>
      new _CreateEditWorkSetsPageState();
}

class _CreateEditWorkSetsPageState extends State<CreateEditWorkSetsPage> {
  List<WorkSet> workSets;

  void _onAdd(String name) {
    workSets.add(
      new WorkSet(name),
    );
  }

  void _onEdit() {}

  @override
  initState() {
    super.initState();

    workSets = new List.from(widget.workSets);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new ActionButton(
            text: 'Save',
            onPressed: () => Navigator.of(context).pop(
                  workSets,
                ),
          ),
        ],
      ),
      body: new CreateEditWorkSetsForm(
        workSets: workSets,
        onAdd: _onAdd,
        onEdit: _onEdit,
      ),
    );
  }
}

class CreateEditWorkSetsForm extends StatelessWidget {
  CreateEditWorkSetsForm({
    Key key,
    this.workSets,
    this.onAdd,
    this.onEdit,
  });

  final List<WorkSet> workSets;
  final Function onAdd;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: workSets.length + 1,
      itemBuilder: (BuildContext context, int indx) {
        if (indx < workSets.length) {
          return new EditableItem(
            order: indx + 1,
            name: workSets[indx].name,
          );
        }

        return new AddItem(
          onSubmitted: onAdd,
        );
      },
    );
  }
}

class EditableItem extends StatelessWidget {
  EditableItem({
    Key key,
    this.order,
    this.name,
  });

  final int order;
  final String name;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new Text(
        '$order. $name',
        style: new TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }
}

class AddItem extends StatelessWidget {
  AddItem({
    Key key,
    this.onSubmitted,
  });

  final Function onSubmitted;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new TextField(
        onSubmitted: onSubmitted,
        decoration: new InputDecoration(
          hintText: 'Name Of Activity',
        ),
      ),
      trailing: new Icon(
        Icons.add,
        color: Colors.lime,
        size: 30.0,
      ),
    );
  }
}
