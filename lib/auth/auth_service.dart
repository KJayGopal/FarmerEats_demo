import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final String? baseUrl = dotenv.env['BASE_URL'];

  // REGISTER USER
  Future<Map<String, dynamic>> registerUser({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      final res = jsonDecode(response.body);
      print("register user response: $res");

      final success = res["success"].toString() == "true";

      return {
        "success": success,
        "message": res["message"],
        "token": res["token"],
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // LOGIN
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "social_id": "email",
          "role": "farmer",
          "type": "email",
        }),
      );

      final data = jsonDecode(response.body);
      debugPrint("login response: $data");

      // Return API response as-is
      return data;
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  //forgot password
  Future<Map<String, dynamic>> forgotPassword({
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/forgot-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mobile": phoneNumber}),
      );

      final data = jsonDecode(response.body);
      print("forgot password data: $data");

      final success = data["success"].toString().toLowerCase() == "true";
      return {"success": success, "message": data["message"]};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // VERIFY OTP
  Future<Map<String, dynamic>> verifyOtp({required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/verify-otp"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"otp": otp}),
      );

      final data = jsonDecode(response.body);

      final success = data["success"].toString() == "true";

      return {
        "success": success,
        "message": data["message"],
        "token": data["token"],
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String token,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/user/reset-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "token": token,
          "password": password,
          "cpassword": confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);
      final success = data["success"].toString() == "true";

      return {"success": success, "message": data["message"]};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
