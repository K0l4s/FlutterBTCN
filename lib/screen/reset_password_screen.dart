// lib/screen/forgot_password_screen/reset_password_screen.dart
import 'package:flutter/material.dart';
import 'package:my_app/screen/login_screen/login_screen.dart';
import 'package:my_app/services/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _codeController = TextEditingController();
  final _newPassController = TextEditingController();

  void _resetPassword() async {
    final result = await AuthService.resetPassword(
      widget.email,
      _codeController.text,
      _newPassController.text,
    );

    if (result['success']) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
      );
    } else {
      _showError(result['error']);
    }
  }

  void _showError(String error) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(error),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset Password")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'OTP Code'),
            ),
            TextField(
              controller: _newPassController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _resetPassword, child: Text('Reset')),
          ],
        ),
      ),
    );
  }
}
