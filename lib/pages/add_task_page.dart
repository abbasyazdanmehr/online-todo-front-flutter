import 'package:flutter/material.dart';
import 'package:todo_clientserver_flutter_app/models/task.dart';
import 'package:todo_clientserver_flutter_app/services/hosts.dart';
import 'package:http/http.dart' as http;

class addTaskPage extends StatefulWidget {
  const addTaskPage({Key? key}) : super(key: key);

  @override
  _addTaskPageState createState() => _addTaskPageState();
}

class _addTaskPageState extends State<addTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputTitle = '';
  String _inputDescription = '';

  Future<int> pushTask(Task task) async {
    final response = await http.post(
      Uri.parse(phone1 + '/tasknew'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: task.toJson(),
    );
    return response.statusCode;
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
              passwordField(),
            ],
          ),
        ),
      ),
    );
  }

  titleField() {
    return TextFormField(
      style: const TextStyle(fontSize: 25),
      decoration: const InputDecoration(
        icon: Icon(Icons.title),
      ),
      validator: (String? value) {
        value ??= '';
        if (value.isEmpty || value == '') {
          return "Invalid title!";
        }
        return null;
      },
      onSaved: (String? value) {
        _inputTitle = value ?? '';
      },
    );
  }

  passwordField() {
    return TextFormField(
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

  signinButton(w, h) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(0.7 * w, 0.07 * h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();

          pushTask(
            Task(
                title: _inputTitle,
                description: _inputDescription,
                status: false),
          );

          Navigator.pop(context);

          setState(() {});
        }
      },
      child: const Text("Add Task"),
    );
  }

  appNameTopWidget(w, h) {
    return SizedBox(
      width: w,
      height: 0.2 * h,
      child: Center(
        child: Text(
          "Add Task",
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
      height: 0.5 * h,
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
