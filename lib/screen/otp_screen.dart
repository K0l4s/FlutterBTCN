// lib/screen/register_screen/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:my_app/screen/login_screen/login_screen.dart';
import 'package:my_app/services/auth_service.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  OtpScreen({required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _codeController = TextEditingController();

  void _submitOtp() async {
    final result = await AuthService.confirmOTP(widget.email, _codeController.text);

    if (result['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
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
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("OK"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(labelText: 'OTP Code'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitOtp,
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}