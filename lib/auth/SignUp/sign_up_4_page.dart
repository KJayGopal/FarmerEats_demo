import 'package:flutter/material.dart';
import 'package:sowlabapp/auth/SignUp/all_done_signup.dart';
import 'package:sowlabapp/auth/auth_service.dart';

class SignUp4Page extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  const SignUp4Page({super.key, required this.registrationData});

  @override
  State<SignUp4Page> createState() => _SignUp4PageState();
}

class _SignUp4PageState extends State<SignUp4Page> {
  final authService = AuthService();
  int selectedDayIndex = 0;

  final List<String> days = ["M", "T", "W", "Th", "F", "S", "Su"];

  final List<String> fullDays = [
    "mon",
    "tue",
    "wed",
    "thu",
    "fri",
    "sat",
    "sun",
  ];

  final List<String> timeSlots = [
    "8:00am - 10:00am",
    "10:00am - 1:00pm",
    "1:00pm - 4:00pm ",
    "4:00pm - 7:00pm ",
    "7:00pm - 10:00pm",
  ];

  // main data
  Map<String, List<String>> businessHours = {
    "mon": [],
    "tue": [],
    "wed": [],
    "thu": [],
    "fri": [],
    "sat": [],
    "sun": [],
  };
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
                    Text("Signup 4 of 4"),
                    SizedBox(height: 8),
                    Text(
                      "Business Hours",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 420,
                      child: Text(
                        "Choose the hours your farm is open for pickups.\nThis will allow customers to order deliveries.",
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: List.generate(days.length, (index) {
                        final isSelected = selectedDayIndex == index;
                        final dayKey = fullDays[index];
                        final hasData = businessHours[dayKey]!.isNotEmpty;

                        return Expanded(
                          child: AspectRatio(
                            aspectRatio: 1.1, //  THIS makes it a square
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDayIndex = index;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xffD5715B)
                                      : hasData
                                      ? Colors.grey.shade200
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xffD5715B)
                                        : hasData
                                        ? Colors.grey.shade200
                                        : Colors.grey.shade300,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    days[index],
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : hasData
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 20),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: timeSlots.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, //  2 per row
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3, // controls width/height ratio
                          ),
                      itemBuilder: (context, index) {
                        final slot = timeSlots[index];
                        final dayKey = fullDays[selectedDayIndex];
                        final isSelected = businessHours[dayKey]!.contains(
                          slot,
                        );

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                businessHours[dayKey]!.remove(slot);
                              } else {
                                businessHours[dayKey]!.add(slot);
                              }
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xfff4c06a)
                                  : const Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(slot),
                          ),
                        );
                      },
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
                // Signup BUTTON
                GestureDetector(
                  onTap: () {
                    widget.registrationData["device_token"] = '12423';
                    widget.registrationData["role"] = 'farmer';
                    widget.registrationData["type"] = 'email';
                    widget.registrationData["social_id"] = '';
                    widget.registrationData["business_hours"] = businessHours;
                    // print(widget.registrationData);
                    final res = authService.registerUser(
                      data: widget.registrationData,
                    );

                    print(res);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AllDoneSignup()),
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
                        "Signup",
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
