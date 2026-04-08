import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sowlabapp/auth/LoginPage/login_page.dart';
import 'package:sowlabapp/auth/auth_service.dart';

class VerifyOtp extends StatefulWidget {
  final String phoneNumber;
  const VerifyOtp({super.key, required this.phoneNumber});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final authService = AuthService();
  String otpCode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FarmerEats"),
            SizedBox(height: 80),
            Text(
              "Verify OTP",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
            SizedBox(height: 40),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;

                  double spacing = 10;
                  double totalSpacing = spacing * 5;

                  double cellWidth = (maxWidth - totalSpacing) / 5;

                  // clamp so it doesn't get too small
                  cellWidth = cellWidth.clamp(42.0, 58.0);

                  return MaterialPinField(
                    theme: MaterialPinTheme(
                      shape: MaterialPinShape.filled,
                      cellSize: Size(
                        cellWidth,
                        cellWidth + 5,
                      ), // keep near-square
                      spacing: spacing,
                      fillColor: Colors.grey.shade100,
                      borderWidth: 0,
                      focusedBorderWidth: 0,
                      borderColor: Colors.transparent,
                      focusedBorderColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      textStyle: TextStyle(
                        fontSize: cellWidth * 0.4, // scale text too
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    length: 5,
                  );
                },
              ),
            ),
            // MaterialPinField(
            //   theme: MaterialPinTheme(
            //     shape: MaterialPinShape.filled,
            //     cellSize: const Size(58, 59),
            //     spacing: 14,

            //     // Background colors (very important when shape is filled)
            //     fillColor:
            //         Colors.grey.shade100, // when this cell is focused
            //     // Optional: Make border completely invisible
            //     borderWidth: 0,
            //     focusedBorderWidth: 0,
            //     borderColor: Colors.transparent,
            //     focusedBorderColor: Colors.transparent,

            //     borderRadius: BorderRadius.circular(12),
            //     textStyle: const TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   length: 6, // number of digits
            //   onChanged: (value) {
            //     // print("Current value: $value");
            //   },
            //   onCompleted: (value) {
            //     print("Completed: $value");
            //     // handle OTP/PIN submission here
            //   },
            //   // Optional: controller
            //   pinController: PinInputController(),
            // ),
            SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Color(0xffd5715b),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final res = await authService.forgotPassword(
                  phoneNumber: widget.phoneNumber,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(res["message"])));
              },
              child: Center(
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
