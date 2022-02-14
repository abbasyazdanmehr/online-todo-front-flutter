import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_clientserver_flutter_app/dbs/statictasks.dart';
import 'package:todo_clientserver_flutter_app/models/task.dart';
import 'package:todo_clientserver_flutter_app/services/hosts.dart';
import 'package:http/http.dart' as http;

class UpdateTaskPage extends StatefulWidget {
  int index;
  UpdateTaskPage(this.index, {Key? key}) : super(key: key);

  @override
  _UpdateTaskPageState createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputTitle = '';
  String _inputDescription = '';
  bool _inputStatus = false;

  @override
  initState() {
    super.initState();
    _inputStatus = Tasks.tasks[widget.index].status;
  }

  Future<int> updateTask(Task updatedTask) async {
    print(phone1 + '/updatetask/${updatedTask.id}/');
    final response = await http.put(
      Uri.parse(phone1 + '/updatetask/${updatedTask.id}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': updatedTask.title,
        'description': updatedTask.description,
        'status': updatedTask.status ? "true" : "false"
      }),
    );
    print(response.statusCode);
    return 0;
  }

  signinForm(w, h) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.1 * w, 0, 0.1 * w, 0.2 * h),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              titleField(),
              heightGap(0.05 * h),
              descriptionField(),
              statusSwitch(),
            ],
          ),
        ),
      ),
    );
  }

  titleField() {
    return TextFormField(
      initialValue: Tasks.tasks[widget.index].title,
      style: const TextStyle(fontSize: 25),
      decoration: const InputDecoration(
        icon: Icon(Icons.title),
      ),
      validator: (String? value) {
        value ??= '';
        if (value.isEmpty || value == '') {
          return "Invalid title!";
        }
        for (var i = 0; i < Tasks.tasks.length; i++) {
          if (i == widget.index) continue;
          if (Tasks.tasks[i].title == value) {
            return "this title is repeated";
          }
        }
        return null;
      },
      onSaved: (String? value) {
        _inputTitle = value ?? '';
      },
    );
  }

  descriptionField() {
    return TextFormField(
      initialValue: Tasks.tasks[widget.index].description,
      maxLines: 2,
      style: const TextStyle(fontSize: 25),
      decoration: const InputDecoration(
        icon: Icon(Icons.description_outlined),
      ),
      validator: (String? value) {
        value ??= '';
        if (value.isEmpty || value == '') {
          return "Invalid Description!";
        }
        return null;
      },
      onSaved: (String? value) {
        _inputDescription = value ?? '';
      },
    );
  }

  statusSwitch() {
    return IconButton(
      onPressed: () {
        _inputStatus = !_inputStatus;
        setState(() {});
        print(_inputStatus);
      },
      icon: _inputStatus
          ? const Icon(Icons.check_circle_sharp)
          : const Icon(Icons.radio_button_unchecked),
    );
  }

  signinButton(w, h) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(0.7 * w, 0.07 * h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          updateTask(
            Task(
              id: Tasks.tasks[widget.index].id,
              title: _inputTitle,
              description: _inputDescription,
              status: _inputStatus,
            ),
          );

          Navigator.pop(context);

          setState(() {});
        }
      },
      child: const Text("Update"),
    );
  }

  appNameTopWidget(w, h) {
    return SizedBox(
      width: w,
      height: 0.2 * h,
      child: Center(
        child: Text(
          "Update",
          style: TextStyle(
            fontSize: 0.1 * h,
          ),
        ),
      ),
    );
  }

  formContainer(w, h) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      width: 0.8 * w,
      height: 0.6 * h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          signinForm(w, h),
          Positioned(
            child: signinButton(w, h),
            bottom: 10,
          )
        ],
      ),
    );
  }

  heightGap(gap) {
    return SizedBox(
      height: gap,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appNameTopWidget(w, h),
              heightGap(0.1 * h),
              formContainer(w, h),
            ],
          ),
        ),
      ),
    );
  }
}
