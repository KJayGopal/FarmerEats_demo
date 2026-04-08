import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sowlabapp/auth/LoginPage/login_page.dart';
import 'package:sowlabapp/auth/auth_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String token = "";
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FarmerEats"),
            SizedBox(height: 80),
            Text(
              "Reset Password",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: "Be Vietnam",
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Remember your password? "),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Color(0xffd5715b),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  _buildPasswordField(),
                  SizedBox(height: 10),
                  _buildConfirmPasswordField(),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final password = _passwordController.text.trim();

                  if (password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter phone number")),
                    );
                    return;
                  }

                  final res = await authService.resetPassword(
                    token: token,
                    password: _passwordController.text.trim(),
                    confirmPassword: _confirmPasswordController.text.trim(),
                  );

                  if (res["message"] ==
                      "Account with this mobile number does not exist.") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Something went wrong.")),
                    );
                  } else {
                    return;
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffD5715B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),

                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: _inputDecoration("New Password", 'assets/icons/lock.svg'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required";
        }

        if (value.length < 6) {
          return "Minimum 6 characters required";
        }

        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return "Must contain 1 uppercase letter";
        }

        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return "Must contain 1 number";
        }

        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: _inputDecoration(
        "Confirm New Password",
        'assets/icons/lock.svg',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please confirm password";
        }

        if (value != _passwordController.text) {
          return "Passwords do not match";
        }

        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String hint, String? svgPath) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
      prefixIcon: svgPath != null
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                svgPath,
                width: 18,
                height: 18,
                fit: BoxFit.contain,
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
      filled: true,
      fillColor: Color(0xfff2f2f2),

      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
