import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sowlabapp/auth/SignUp/sign_up_3_page.dart';

class SignUp2Page extends StatefulWidget {
  final Map<String, dynamic> registrationData;
  const SignUp2Page({super.key, required this.registrationData});

  @override
  State<SignUp2Page> createState() => _SignUp2PageState();
}

class _SignUp2PageState extends State<SignUp2Page> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _informalNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

  String? selectedState;

  final List<String> states = ["New York", "California", "Texas", "Florida"];
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
                    Text("Signup 2 of 4"),
                    SizedBox(height: 8),
                    Text(
                      "Farm Info",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUnfocus,
                      child: Column(
                        children: [
                          //Business Name
                          TextFormField(
                            controller: _businessNameController,
                            decoration: _inputDecoration(
                              "Business Name",
                              'assets/icons/business.svg',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          //Informal Name
                          TextFormField(
                            controller: _informalNameController,
                            decoration: _inputDecoration(
                              "Informal Name",
                              "assets/icons/informal.svg",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Informal name is required";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          // ADDRESS
                          TextFormField(
                            controller: _addressController,
                            decoration: _inputDecoration(
                              "Street Address",
                              'assets/icons/home.svg',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Address is required";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 12),

                          // CITY
                          TextFormField(
                            controller: _cityController,
                            decoration: _inputDecoration(
                              "City",
                              'assets/icons/location.svg',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "City is required";
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 12),

                          Row(
                            children: [
                              // STATE DROPDOWN
                              Expanded(
                                flex: 3,
                                child: DropdownButtonFormField<String>(
                                  initialValue: selectedState,
                                  decoration: _inputDecoration("State", null),
                                  items: states.map((state) {
                                    return DropdownMenuItem(
                                      value: state,
                                      child: Text(state),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedState = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select state";
                                    }
                                    return null;
                                  },
                                ),
                              ),

                              SizedBox(width: 3),

                              // ZIPCODE
                              Expanded(
                                flex: 4,
                                child: TextFormField(
                                  controller: _zipController,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration(
                                    "Enter Zipcode",
                                    null,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    if (!RegExp(
                                      r'^[0-9]{5,6}$',
                                    ).hasMatch(value)) {
                                      return "Invalid zip";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),

                    SizedBox(height: 60),
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
                    if (_formKey.currentState!.validate()) {
                      // save into formData
                      widget.registrationData["business_name"] =
                          _businessNameController.text;
                      widget.registrationData["informal_name"] =
                          _informalNameController.text;
                      widget.registrationData["address"] =
                          _addressController.text;
                      widget.registrationData["city"] = _cityController.text;
                      widget.registrationData["state"] = selectedState;
                      widget.registrationData["zip_code"] = int.parse(
                        _zipController.text,
                      );

                      // go next
                    }
                    if (_addressController.text.isEmpty ||
                        _cityController.text.isEmpty ||
                        selectedState == null ||
                        _zipController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please fill all required fields"),
                        ),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SignUp3Page(
                          registrationData: widget.registrationData,
                        ),
                      ),
                    );
                    print(widget.registrationData);
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
