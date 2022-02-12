import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  Widget formFields(context) {
    String _inputUsername = 'blank';
    String _inputPassword = 'blank';

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Creditor Name',
                  ),
                  validator: (String? value) {
                    value ??= 'blank';

                    if (value.isEmpty || value == 'blank') {
                      return 'Invalid username';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? value) => _inputUsername = value ?? '0',
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: 'Description',
                  ),
                  validator: (String? value) {
                    value ??= 'blank';
                    if (value.isEmpty || value == 'blank') {
                      return 'Invalid password';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String? value) => _inputPassword = value ?? '0',
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(_inputUsername + ", " + _inputPassword);
                setState(() {});
              }
            },
            child: const Text(
              'Sign In',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: formFields(context),
    );
  }
}
