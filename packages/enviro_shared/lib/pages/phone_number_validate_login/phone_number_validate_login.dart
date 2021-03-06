import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enviro_shared/logic/logic.dart';
import 'package:enviro_shared/shared_widget/shared_widget.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:enviro_shared/utils/utils.dart';

class LoginPhoneNumberValidatePage extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onSuccess;
  const LoginPhoneNumberValidatePage({
    Key? key,
    required this.phoneNumber,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<LoginPhoneNumberValidatePage> createState() =>
      _LoginPhoneNumberStateValidate();
}

class _LoginPhoneNumberStateValidate
    extends State<LoginPhoneNumberValidatePage> {
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

  void submit(String loginCode) async {
    if (loginCode.length == 5) {
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
                content: Text("???????? ?????? ????????"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is AuthLoginInputError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${state.message} : ???????? ???? 55555 ???????? ????????",
                ),
              ),
            );
          }
          if (state is AuthLoginInputSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            widget.onSuccess();
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(
                color: Colors.black,
              ),
              title: const Text(
                '?????????? ?????????? ????????',
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
                                      setState(() {
                                        loginCode = value;
                                      });
                                    },
                                    onSubmit: (String pin) async {
                                      if (pin.length == 5) {
                                        submit(pin);
                                      }
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
                                  onSubmit: loginCode.length == 5
                                      ? () => submit(loginCode)
                                      : null,
                                  isLoading: state is AuthLoginInputLoading,
                                  loadingTitle: "???? ?????? ??????????",
                                  title: "????????",
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
