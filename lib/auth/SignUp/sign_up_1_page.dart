import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sowlabapp/auth/LoginPage/login_page.dart';
import 'package:sowlabapp/auth/SignUp/sign_up_2_page.dart';

class SignUpPage extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  const SignUpPage({super.key, required this.registrationData});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    Text("FarmerEats"),
                    SizedBox(height: 35),
                    Text("Signup 1 of 4"),
                    SizedBox(height: 8),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton('assets/logos/google.png'),
                        SizedBox(width: 12),
                        _socialButton("assets/logos/apple.png"),
                        SizedBox(width: 12),
                        _socialButton("assets/logos/facebook.png"),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Text(
                        "or signup with ",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: Column(
                        children: [
                          _buildNameField(),
                          SizedBox(height: 10),
                          _buildEmailField(),
                          SizedBox(height: 10),
                          _buildPhoneField(),
                          SizedBox(height: 10),
                          _buildPasswordField(),
                          SizedBox(height: 10),
                          _buildConfirmPasswordField(),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),

                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      widget.registrationData["full_name"] =
                          _nameController.text;
                      widget.registrationData["email"] = _emailController.text;
                      widget.registrationData["phone"] = _phoneController.text;
                      widget.registrationData["password"] =
                          _passwordController.text;
                      // Move to next step
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignUp2Page(
                            registrationData: widget.registrationData,
                          ),
                        ),
                      );
                      print(widget.registrationData);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffD5715B),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: _inputDecoration("Full Name", 'assets/icons/person.svg'),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Full name is required";
        }
        if (value.length < 3) {
          return "Enter valid name";
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration("Email Address", 'assets/icons/email.svg'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required";
        }

        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        if (!emailRegex.hasMatch(value)) {
          return "Enter valid email";
        }

        return null;
      },
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: _inputDecoration("Phone Number", 'assets/icons/phone.svg'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Phone number is required";
        }

        if (!RegExp(r'^\+[0-9]{12}$').hasMatch(value)) {
          return "Enter valid number with country code (e.g. +1234567890)";
        }

        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: _inputDecoration("Password", 'assets/icons/lock.svg'),
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
        "Re-enter Password",
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

  Widget _socialButton(String asset) {
    return Container(
      width: 90,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(child: Image.asset(asset, height: 24)),
    );
  }
}
