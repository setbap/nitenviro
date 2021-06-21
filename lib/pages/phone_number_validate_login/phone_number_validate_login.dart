import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nitenviro/index.dart';

import 'package:pinput/pin_put/pin_put.dart';
import 'package:nitenviro/shared_widget/background_circle_painter.dart';
import 'package:nitenviro/utils/colors.dart';

class LoginPhoneNumberValidate extends StatefulWidget {
  static const String path = "/login";
  const LoginPhoneNumberValidate({Key? key}) : super(key: key);

  @override
  State<LoginPhoneNumberValidate> createState() =>
      _LoginPhoneNumberStateValidate();
}

class _LoginPhoneNumberStateValidate extends State<LoginPhoneNumberValidate> {
  String phoneNumber = "";
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      _pinPutFocusNode.requestFocus();
    });
  }

  void submit() {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint(phoneNumber);
      Navigator.pushNamedAndRemoveUntil(context, Index.path, (route) => false);
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
          center: Offset(size.width * 3 / 4, 20),
          isRightPrimary: false,
        ),
        const CirclePaintInfo(
          radius: 10,
          center: Offset(100, 100),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 40,
          center: Offset(0, size.height / 4),
        ),
        CirclePaintInfo(
          radius: 80,
          center: Offset(size.width, size.height / 2),
        ),
        CirclePaintInfo(
          radius: 80,
          center: Offset(size.width, size.height),
        ),
        CirclePaintInfo(
          radius: 90,
          center: Offset(0, size.height / 1.2),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'تایید شماره تلفن',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
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
                          SizedBox(
                            width: 6 * 60,
                            child: PinPut(
                              eachFieldWidth: 50,
                              eachFieldHeight: 50,
                              fieldsCount: 5,
                              onSubmit: (String pin) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, Index.path, (route) => true);
                                _showSnackBar(pin, context);
                              },
                              focusNode: _pinPutFocusNode,
                              controller: _pinPutController,
                              inputDecoration: const InputDecoration(
                                filled: false,
                                focusedBorder: InputBorder.none,
                              ),
                              submittedFieldDecoration: BoxDecoration(
                                border: Border.all(color: darkGreen),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              selectedFieldDecoration: BoxDecoration(
                                border: Border.all(color: darkGreen),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              followingFieldDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  color: mainYellow,
                                  width: 2,
                                ),
                              ),
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
        ),
      ),
    );
  }

  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: SizedBox(
        height: 40.0,
        child: Center(
          child: Text(
            'با موفقیت وارد شدید.',
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.deepPurpleAccent,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
