import 'package:flutter/material.dart';
import '../controller/controller.dart';
import './add_screen.dart';
import '../model/model.dart';

class TaskBody extends StatefulWidget {
  @override
  _TaskBodyState createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  Future<List<Task>> _tasksList;
  String _taskName;
  bool isUpdate = false;
  int taskIdForUpdate;
  bool isChaked = false;
  // var itemCount;
  final Controller _con = Controller();

  @override
  void initState() {
    super.initState();
    updateTaskList();
  }

  updateTaskList() {
    setState(() {
      _tasksList = _con.getTask();
      // itemCount = DBProvider.db.getCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTaskList();
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 40.0,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Todoye',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    GestureDetector(
                      child: Icon(Icons.delete_forever,
                          color: Colors.white, size: 35.0),
                      onTap: () {
                        setState(() {
                          _con.deleteAll();
                          updateTaskList();
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Expanded(
                child: FutureBuilder(
                  future: _tasksList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // itemCount = snapshot.data.length;
                      return getTask(snapshot.data);
                    }
                    if (snapshot.data == null || snapshot.data.length == 0) {
                      return Text('No Data Found');
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                child: AddScreen((value) {
                  setState(() {
                    _con.insertTask(value);
                    updateTaskList();
                  });
                }, ''),
              ),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }

  getTask(List<Task> lst) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: GestureDetector(
            child: Text(
              lst[index].name,
              style: TextStyle(
                fontSize: 22.0,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    child: AddScreen((value) {
                      _con.updateTask(lst, value, index);
                      updateTaskList();
                    }, lst[index].name),
                  ),
                ),
              );
            },
          ),
          trailing: GestureDetector(
              child: Icon(
                Icons.delete_forever_outlined,
              ),
              onTap: () {
                _con.deleteTask(lst, index);
                updateTaskList();
              }),
        );
      },
      itemCount: lst.length,
    );
  }
}
