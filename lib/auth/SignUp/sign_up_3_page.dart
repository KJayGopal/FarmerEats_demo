import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sowlabapp/auth/SignUp/sign_up_4_page.dart';

class SignUp3Page extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  const SignUp3Page({super.key, required this.registrationData});

  @override
  State<SignUp3Page> createState() => _SignUp3PageState();
}

class _SignUp3PageState extends State<SignUp3Page> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const .symmetric(horizontal: 30.0, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text("Signup 3 of 4"),
                    SizedBox(height: 8),
                    Text(
                      "Verification",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 350,
                      child: Text(
                        "Attached proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic",
                        textAlign: TextAlign.left,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Attach proof of registration"),
                        GestureDetector(
                          onTap: () {
                            widget.registrationData["registration_proof"] =
                                "proof.pdf";
                            setState(() {
                              if (!isTapped) {
                                isTapped = true;
                              } else {
                                isTapped = false;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xffD5715B),
                              shape: BoxShape.circle,
                            ),

                            child: SvgPicture.asset(
                              "assets/icons/camera.svg",
                              width: 23.9,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    if (isTapped)
                      Container(
                        padding: .symmetric(horizontal: 17, vertical: 15),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "usda_registration.pdf",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                widget.registrationData.remove(
                                  "registration_proof",
                                );
                                setState(() => isTapped = false);
                              },
                              child: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),

                Spacer(),
                // CONTINUE BUTTON
                GestureDetector(
                  onTap: () {
                    if (!isTapped) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please attach registration proof"),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUp4Page(
                          registrationData: widget.registrationData,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color(0xffD5715B),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
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
}
