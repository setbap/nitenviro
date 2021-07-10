import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/pages.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';

class LoginPhoneNumber extends StatelessWidget {
  static const String path = "/auth";
  const LoginPhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthPhoneInputCubit>(
      create: (context) => AuthPhoneInputCubit(
        rubbishCollectorsApi: context.read<RubbishCollectorsApi>(),
      ),
      child: const LoginPhoneNumberProvided(),
    );
  }
}

class LoginPhoneNumberProvided extends StatefulWidget {
  static const String path = "/auth";
  const LoginPhoneNumberProvided({Key? key}) : super(key: key);

  @override
  State<LoginPhoneNumberProvided> createState() =>
      _LoginPhoneNumberProvidedState();
}

class _LoginPhoneNumberProvidedState extends State<LoginPhoneNumberProvided> {
  String phoneNumber = "";
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  void submit() {
    _formKey.currentState?.save();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthPhoneInputCubit>().sendCode(phoneNumber);
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
      child: BlocListener<AuthPhoneInputCubit, AuthPhoneInputState>(
        listener: (context, state) {
          if (state is AuthPhoneInputLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("لطفا صبر کنید"),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          if (state is AuthPhoneInputError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushNamed(
              context,
              LoginPhoneNumberValidate.path,
              arguments: phoneNumber,
            );
          }
          if (state is AuthPhoneInputSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content:
                      Text("حالت توسعه: لطفا برای ورود کد 55555 وارد کنید"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 10),
                ),
              );
            Navigator.pushNamed(
              context,
              LoginPhoneNumberValidate.path,
              arguments: phoneNumber,
            );
          }
        },
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
                            BlocBuilder<AuthPhoneInputCubit,
                                AuthPhoneInputState>(
                              builder: (context, state) {
                                return BTNWithLoading(
                                  onSubmit: submit,
                                  isLoading: state is AuthPhoneInputLoading,
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
