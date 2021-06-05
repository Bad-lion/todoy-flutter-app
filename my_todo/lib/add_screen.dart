import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddScreen extends StatelessWidget {
  final Function addCallBack;
  final String string;
  String _taskTitle;

  AddScreen(this.addCallBack, this.string);

  @override
  Widget build(BuildContext context) {
    bool isChecked = string == '' ? true : false;
    return Container(
      color: Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            )),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isChecked ? 'Add Task' : 'Update task',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: TextEditingController(text: string),
              onChanged: (value) {
                _taskTitle = value;
              },
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 24.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (_taskTitle == null || _taskTitle.trim() == '') {
                  Fluttertoast.showToast(
                      msg: "add some title",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black87,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  addCallBack(_taskTitle);
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  isChecked ? 'Add' : 'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
