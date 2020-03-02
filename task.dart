
// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';
import 'dart:async';

import 'home_page.dart';

void task() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Tasks List',
        home: new TodoList()

    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();

}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];
  List<bool> _dones = [];
  //bool clicked = false;


// Instead of autogenerating a todo item, _addTodoItem now accepts a string
  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      _dones.add(false);
      setState(() => _todoItems.add(task));
    }
  }
  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task'),
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )

              );
            }
        )
    );
  }
  // Much like _addTodoItem, this modifies the array of todo strings and
// notifies the app that the state has changed by using setState
  void _removeTodoItem(int index) {
    _dones.removeAt(index);
    setState(() => _todoItems.removeAt(index));
  }
  // Show an alert dialog asking the user to confirm that the task is done
  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              title: new Text('Are you sure you wanna remove "${_todoItems[index]}" ?'),
              actions: <Widget>[
                new FlatButton(
                    child: new Text('CANCEL'),
                    onPressed: () => Navigator.of(context).pop()
                ),
                new FlatButton(
                    child: new Text('YES'),
                    onPressed: () {
                      _removeTodoItem(index);
                      Navigator.of(context).pop();
                    }
                )
              ]
          );
        }
    );
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
      },
    );
  }


  Widget _buildTodoItem(String todoText, int index) {
//    return new ListTile(
//        title: new Text(todoText),
//        onTap: () => _promptRemoveTodoItem(index)
//
//    );
    return Container(

      margin: EdgeInsets.only(top: 8,bottom: 8),

      padding: EdgeInsets.all(16),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 3), color: Colors.black12, blurRadius: 6)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              _dones[index] = !_dones[index];
              }),
            onLongPress: () => _promptRemoveTodoItem(index),
            child: _dones[index] ? Icon(Icons.check_circle, color: Colors.white) : Icon(Icons.radio_button_unchecked, color: Colors.white),
          ),
          SizedBox(width: 8),
          Text(
            todoText,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Task List'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.close),
            onPressed:  homepage,
          ),
        ],
        leading: new Container(),
      ),

      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );

  }
}
