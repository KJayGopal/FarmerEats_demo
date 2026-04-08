import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sowlabapp/auth/LoginPage/forgot_password.dart';
import 'package:sowlabapp/auth/SignUp/all_done_signup.dart';
import 'package:sowlabapp/auth/SignUp/sign_up_1_page.dart';
import 'package:sowlabapp/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hasTypedPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FarmerEats", style: TextStyle(fontFamily: "Be Vietnam")),
              SizedBox(height: 70),
              Text(
                "Welcome back!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Be Vietnam",
                ),
              ),
              SizedBox(height: 40),
              Row(
                children: [
                  Text(
                    "New here? ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to the sign-up page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SignUpPage(registrationData: {}),
                        ),
                      );
                    },
                    child: Text(
                      "Create account",
                      style: TextStyle(
                        color: Color(0xffd5715b),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Be Vietnam",
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUnfocus,
                child: Column(
                  children: [
                    _buildEmailField(),
                    SizedBox(height: 16),
                    _buildPasswordField(),
                  ],
                ),
              ),

              SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    // Move to next step
                    final res = await authService.loginUser(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );

                    if (res["success"] == true) {
                      _passwordController.clear();
                      _emailController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login Successful"),
                          duration: Duration(milliseconds: 60),
                        ),
                      );
                      // sleep(Duration(seconds: 1));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllDoneSignup(),
                        ),
                      );

                      // final token = res["token"];
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res["message"] ?? "Login Failed"),
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffD5715B),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Be Vietnam",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  "or login with",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton("assets/logos/google.png"),
                  Spacer(),
                  _socialButton("assets/logos/apple.png"),
                  Spacer(),
                  _socialButton("assets/logos/facebook.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SvgPicture.asset(
            "assets/icons/email.svg",
            width: 10,
            height: 10,
            fit: BoxFit.contain,
          ),
        ),
        filled: true,
        fillColor: Color(0xfff2f2f2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter email";
        }

        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        if (!emailRegex.hasMatch(value)) {
          return "Enter valid email";
        }

        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onChanged: (value) {
        setState(() {
          _hasTypedPassword = value.isNotEmpty;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter password";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(9.0),
          child: SvgPicture.asset(
            "assets/icons/lock.svg",
            width: 10,
            height: 10,
            fit: BoxFit.contain,
          ),
        ),
        suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: !_hasTypedPassword
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "Forgot?",
                    style: TextStyle(
                      color: Color(0xffd5715b),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            : null,

        filled: true,
        fillColor: Color(0xfff2f2f2),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
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
      child: Center(child: Image.asset(asset, height: 30)),
    );
  }
}
