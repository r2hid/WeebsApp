import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wibu_app/presentation/viewmodels/user_viewmodel.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    userViewModel.getAllUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: userViewModel.allUsers == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: userViewModel.allUsers!.length,
        itemBuilder: (context, index) {
          final user = userViewModel.allUsers![index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username: ${user.username}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Password: ${user.password}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Status: ${user.isAdmin ? 'Admin' : 'User'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}