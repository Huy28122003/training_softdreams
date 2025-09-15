import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpCodeScreen extends StatefulWidget {
  const OtpCodeScreen({super.key});

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: OtpPinField(
          otpPinFieldStyle: OtpPinFieldStyle(),
          onSubmit: (value) {},
          onChange: (value) {},
        ),
      ),
    );
  }
}
