import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nitenviro/pages/phone_number_validate_login/phone_number_validate_login.dart';
import 'package:nitenviro/shared_widget/background_circle_painter.dart';
import 'package:nitenviro/utils/colors.dart';

class LoginPhoneNumber extends StatefulWidget {
  static const String path="/auth";
  const LoginPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginPhoneNumber> createState() => _LoginPhoneNumberState();
}

class _LoginPhoneNumberState extends State<LoginPhoneNumber> {
  String phoneNumber = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void submit() {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint(phoneNumber);
      Navigator.pushNamed(context, LoginPhoneNumberValidate.path);
    } else {
      debugPrint("phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
            radius: 40,
            center: Offset(size.width, size.height / 2),
            isRightPrimary: false),
        CirclePaintInfo(
          radius: 40,
          center: Offset(0, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 90,
          center: Offset(0, size.height / 1.2),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'ورود',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/3.png",
                            width: 200,
                            height: 200,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onSaved: (newValue) {
                              phoneNumber = newValue ?? "";
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.length < 11) {
                                return "شماره تلفن نادرست می باشد. طول آن 11 باید باشد.";
                              }
                              if (!value.startsWith("09")) {
                                return "شماره تلفن باید با 09 شروع شود.";
                              }
                            },
                            autocorrect: false,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 11,
                            decoration: const InputDecoration(
                              hintText: "شماره همراه",
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ElevatedButton(
                            onPressed: submit,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              primary: darkGreen,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ورود",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // persistentFooterButtons: [
          //   Center(
          //     child: Text.rich(
          //       TextSpan(
          //         text: 'حساب ندارید؟  ',
          //         style: const TextStyle(fontSize: 18),
          //         children: <TextSpan>[
          //           TextSpan(
          //               text: 'ایجاد حساب',
          //               style: const TextStyle(
          //                 decoration: TextDecoration.underline,
          //                 color: Colors.lightBlue,
          //               ),
          //               recognizer: TapGestureRecognizer()
          //                 ..onTap = () {
          //                   // TODO: go ijad hesab
          //                 }),
          //           // can add more TextSpans here...
          //         ],
          //       ),
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
