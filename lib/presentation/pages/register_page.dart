import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/viewmodels/user_viewmodel.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    bool success = await Provider.of<UserViewModel>(context, listen: false)
                        .register(username, password);
                    if (success) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Register'),
                ),
                Consumer<UserViewModel>(
                  builder: (context, userViewModel, child) {
                    if (userViewModel.error != null) {
                      return Text(
                        userViewModel.error!,
                        style: TextStyle(color: Colors.red),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}