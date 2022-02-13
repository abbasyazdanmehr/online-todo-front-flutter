import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_clientserver_flutter_app/dbs/statictasks.dart';
import 'package:todo_clientserver_flutter_app/models/task.dart';
import 'package:http/http.dart' as http;
import 'package:todo_clientserver_flutter_app/pages/add_task_page.dart';
import 'package:todo_clientserver_flutter_app/services/hosts.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({Key? key}) : super(key: key);

  @override
  _TasksListPageState createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  // String _now = '';
  // Timer _everySecond = Timer.periodic(const Duration(seconds: 0), (timer) {});
  @override
  initState() {
    super.initState();

    // _now = DateTime.now().second.toString();

    // _everySecond = Timer.periodic(const Duration(seconds: 1), (Timer t) {
    //   setState(() {
    //     _now = DateTime.now().second.toString();
    //     print(_now);
    //     fetchAllTask();
    //   });
    // });

    fetchAllTask();
  }

  Future<int> fetchAllTask() async {
    final response = await http.get(Uri.parse(phone1));
    final body = utf8.decode(response.bodyBytes);
    print(body);
    List<dynamic> jsonTaskString = jsonDecode(body);
    Tasks.tasks = [];
    for (var i = 0; i < jsonTaskString.length; i++) {
      Tasks.tasks.add(
        Task(
          title: jsonTaskString[i]['title'],
          description: jsonTaskString[i]['description'],
          status: jsonTaskString[i]['status'],
        ),
      );
    }
    return 0;
  }

  Future<Task> fetchTask(int index) async {
    final response = await http.get(Uri.parse(phone1 + '/$index/'));
    if (response.statusCode == 200) {
      print(response.body);
      return Task.fromJson(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to load album');
    }
  }

  Future<http.Response> deleteAlbum(int index) async {
    final http.Response response = await http.delete(
      Uri.parse(phone1 + '/taskdestroy/${Tasks.tasks[index].title}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);

    return response;
  }

  blockContent(i) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Tasks.tasks[i].status
            ? Colors.green.withOpacity(0.5)
            : Colors.red.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onLongPress: () {
          _showMyDialog(i);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Tasks.tasks[i].title,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              Tasks.tasks[i].description,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Are shure for delete?"),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                deleteAlbum(index);
                fetchAllTask();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchAllTask();
          setState(() {});
        },
        child: ListView(
          children: [
            for (var i = 0; i < Tasks.tasks.length; i++) blockContent(i),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addTaskPage()),
          );
        },
      ),
    );
  }
}
