import 'package:AideApp/Screens/TodoList/edit-task.dart';
import 'package:AideApp/Widgets/Re-usable/header.dart';
import 'package:flutter/material.dart';

class ViewTask extends StatefulWidget {
  @override
  _ViewTaskState createState() => _ViewTaskState();
}

taskCard() {
  return Card(
    child: ListTile(
      leading: CircleAvatar(),
      title: Text('Task Name'),
      subtitle: Text('Location'),
      trailing: Text('9m'),
    ),
  );
}

progressTrack(context) {
  return new Center(
    child: new Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/milky-way.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Things',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    '10-6-2020',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          noOfTasks(),
        ],
      ),
    ),
  );
}

taskNo(String numberTask, String taskCat) {
  return Column(
    children: <Widget>[
      Text(
        numberTask,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      Text(
        taskCat,
        style: TextStyle(color: Colors.white, fontSize: 10.0),
      ),
    ],
  );
}

noOfTasks() {
  return Expanded(
    flex: 1,
    child: Container(
      decoration: BoxDecoration(color: Colors.black45.withOpacity(0.3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              taskNo('24', 'personal'),
              taskNo('16', 'business'),
            ],
          ),
          Text(
            'Progress 65% done ',
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    ),
  );
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,
          titleText: 'Tasks',
          icons: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditTask()));
            },
          )),
      body: Column(
        children: <Widget>[
          progressTrack(context),
          Divider(),
          Text('List'),
          Divider(),
          taskCard(),
        ],
      ),
    );
  }
}
