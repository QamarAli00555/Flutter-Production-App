import 'package:flutter/material.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class OtpFields extends StatelessWidget {
  final OtpFieldControllerV2 controllerV2;
  final bool visible;
  final Function(String?) onCompleted;
  const OtpFields(
      {super.key,
      required this.controllerV2,
      required this.visible,
      required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: OTPTextFieldV2(
        controller: controllerV2,
        length: 4,
        width: MediaQuery.of(context).size.width,
        textFieldAlignment: MainAxisAlignment.spaceAround,
        fieldWidth: 45,
        fieldStyle: FieldStyle.box,
        outlineBorderRadius: 15,
        style: const TextStyle(fontSize: 17),
        onChanged: (pin) {
          print("Changed: $pin");
        },
        onCompleted: (pin) {
          onCompleted(pin);
        },
      ),
    );
  }
}
