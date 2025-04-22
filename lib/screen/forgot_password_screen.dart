// lib/screen/forgot_password_screen/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:my_app/screen/reset_password_screen.dart';
import 'package:my_app/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  void _submit() async {
    final result = await AuthService.forgotPassword(_emailController.text);

    if (result['success']) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: _emailController.text),
        ),
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
      appBar: AppBar(title: Text("Forgot Password")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text('Send OTP')),
          ],
        ),
      ),
    );
  }
}
