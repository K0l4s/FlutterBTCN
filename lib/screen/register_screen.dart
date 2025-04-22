import 'package:flutter/material.dart';
import 'package:my_app/screen/otp_screen.dart';
import 'package:my_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstnameCtrl = TextEditingController();
  final TextEditingController lastnameCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController birthdayCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController repeatPsswdCtrl = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  void _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final data = {
      "firstname": firstnameCtrl.text,
      "lastname": lastnameCtrl.text,
      "address": addressCtrl.text,
      "birthday": birthdayCtrl.text,
      "phone": phoneCtrl.text,
      "email": emailCtrl.text,
      "password": passwordCtrl.text,
      "repeat_psswd": repeatPsswdCtrl.text,
    };

    final result = await AuthService.register(data);

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký thành công, hãy xác nhận OTP")),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => OtpScreen(email: emailCtrl.text)),
      );

      // TODO: Điều hướng sang màn hình xác nhận OTP nếu có
    } else {
      setState(() {
        _errorMessage = result['error'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng ký")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Họ", firstnameCtrl),
              _buildTextField("Tên", lastnameCtrl),
              _buildTextField("Địa chỉ", addressCtrl),
              _buildTextField("Ngày sinh (yyyy-mm-dd)", birthdayCtrl),
              _buildTextField("Số điện thoại", phoneCtrl),
              _buildTextField("Email", emailCtrl, keyboardType: TextInputType.emailAddress),
              _buildTextField("Mật khẩu", passwordCtrl, obscureText: true),
              _buildTextField("Nhập lại mật khẩu", repeatPsswdCtrl, obscureText: true),
              if (_errorMessage.isNotEmpty) ...[
                SizedBox(height: 10),
                Text(_errorMessage, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _register,
                child: Text("Đăng ký"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Không được để trống' : null,
      ),
    );
  }
}
