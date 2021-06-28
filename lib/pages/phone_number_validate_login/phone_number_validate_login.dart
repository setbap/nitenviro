import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/pages/pages.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:nitenviro/utils/utils.dart';

class LoginPhoneNumberValidate extends StatefulWidget {
  final String phoneNumber;
  static const String path = "/login";
  const LoginPhoneNumberValidate({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<LoginPhoneNumberValidate> createState() =>
      _LoginPhoneNumberStateValidate();
}

class _LoginPhoneNumberStateValidate extends State<LoginPhoneNumberValidate> {
  String loginCode = "";
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

  void submit() async {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() ?? false) {
      debugPrint("$loginCode ${widget.phoneNumber}");
      context.read<AuthLoginInputCubit>().login(
            widget.phoneNumber,
            int.parse(loginCode),
          );
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
      child: BlocListener<AuthLoginInputCubit, AuthLoginInputState>(
        listener: (context, state) {
          if (state is AuthLoginInputLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("لطفا صبر کنید"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is AuthLoginInputError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
          if (state is AuthLoginInputSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Index.path,
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
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
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Builder(builder: (context) {
                                return SizedBox(
                                  width: 6 * 60,
                                  child: PinPut(
                                    eachFieldWidth: 50,
                                    eachFieldHeight: 50,
                                    fieldsCount: 5,
                                    onChanged: (value) {
                                      loginCode = value;
                                    },
                                    onSubmit: (String pin) async {
                                      submit();
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
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            BlocBuilder<AuthLoginInputCubit,
                                AuthLoginInputState>(
                              builder: (context, state) {
                                return BTNWithLoading(
                                  onSubmit: submit,
                                  isLoading: state is AuthLoginInputLoading,
                                  loadingTitle: "در حال ارسال",
                                  title: "ورود",
                                );
                              },
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
      ),
    );
  }
}
