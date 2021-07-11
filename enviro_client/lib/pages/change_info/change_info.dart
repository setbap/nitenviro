import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/add_building/add_building_form.dart';
import 'package:nitenviro/pages/new_request/widgets/reminder_time.dart';
import 'package:nitenviro/shared_widget/shared_widget.dart';
import 'package:nitenviro/utils/utils.dart';

class ChangeInfo extends StatefulWidget {
  final String? name;
  final String? email;
  final String? avatarUrl;

  const ChangeInfo({
    Key? key,
    this.name,
    this.email,
    this.avatarUrl,
  }) : super(key: key);

  @override
  State<ChangeInfo> createState() => _ChangeInfoState();
}

class _ChangeInfoState extends State<ChangeInfo> {
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  File? _file;

  @override
  void initState() {
    nameInputController.text = widget.name ?? "";
    emailInputController.text = widget.email ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundCirclePainter(
      circlesPainter: (size) => [
        CirclePaintInfo(
          radius: 20,
          center: Offset(size.width / 8, size.height / 8),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 15,
          center: Offset(size.width / 2, size.height / 20),
        ),
        CirclePaintInfo(
          radius: 20,
          center: Offset(size.width - 20, size.height / 20),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 75,
          center: Offset(50, size.height),
          isRightPrimary: false,
        ),
        CirclePaintInfo(
          radius: 30,
          center: Offset(size.width - 90, size.height),
          isRightPrimary: false,
        ),
      ],
      child: BlocConsumer<UserInfoCubit, UserInfoState>(
        listener: (context, state) {
          if (state is UserInfoSuccess) {
            imageCache?.clear();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "پروفایل به روز رسانی شد",
                  ),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                ),
              );
            Navigator.pop(context);
          }
        },
        listenWhen: (previous, current) =>
            previous is UserInfoLoading && current is UserInfoSuccess,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                "تغییر مشخصات",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  CircleAvatarWithEdit(
                    onChanged: (file) {
                      _file = file;
                    },
                    url: widget.avatarUrl ??
                        "https://pfpmaker.com/_nuxt/img/profile-3-1.3e702c5.png",
                  ),
                  const SizedBox(height: 24),
                  NEFormTextInput(
                    textEditingController: nameInputController,
                    textInputFormatter: const [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      } else if (value.length < 4) {
                        return "نام باید بیش از 3 حرف باشد";
                      }
                    },
                    iconData: Icons.account_circle,
                    label: "نام و نام خانوادگی",
                    hint: "سینا ابراهیمی",
                  ),
                  const SizedBox(height: 8),
                  NEFormTextInput(
                    textEditingController: emailInputController,
                    textInputFormatter: const [],
                    inputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null;
                      } else if (!isEmail(value)) {
                        return "ایمیل وارد شده صحیح نمی باشد";
                      }
                    },
                    iconData: Icons.mail,
                    label: "ایمیل",
                    hint: "example@example.com",
                  ),
                  const SizedBox(height: 16),
                  BTNWithLoading(
                    onSubmit: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UserInfoCubit>().updateUserInfo(
                              name: nameInputController.text,
                              email: emailInputController.text,
                              avatar: _file,
                            );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "اطلاعات در حال ارسال میباشد",
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("اطلاعات نادرست می باشد"),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    title: "ثبت مشخصات",
                    isLoading: state is UserInfoLoading,
                    loadingTitle: "در حال ارسال ",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CircleAvatarWithEdit extends StatefulWidget {
  final FnWithOneParam<File?> onChanged;
  final String? url;
  const CircleAvatarWithEdit({
    Key? key,
    required this.onChanged,
    this.url,
  }) : super(key: key);

  @override
  _CircleAvatarWithEditState createState() => _CircleAvatarWithEditState();
}

class _CircleAvatarWithEditState extends State<CircleAvatarWithEdit> {
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _image = await _cropImage(_image!);
      widget.onChanged(_image);
      setState(() {});
    }
    // else {}
  }

  Future<File?> _cropImage(File _image) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'برش تصویر',
          statusBarColor: yellowDarken,
          toolbarColor: yellowDarken,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        maxHeight: 1000,
        maxWidth: 1000,
        iosUiSettings: const IOSUiSettings(
          title: 'برش تصویر',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      return _image;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 56,
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          if (_image != null)
            Container(
              width: 112,
              height: 112,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: Image.file(
                _image!,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.account_circle,
                  size: 112,
                  color: Colors.grey,
                ),
              ),
            )
          else
            Container(
              width: 112,
              height: 112,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: Image.network(
                widget.url ?? "",
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.account_circle,
                  size: 112,
                  color: Colors.grey,
                ),
              ),
            ),
          SizedBox(
            width: 112,
            child: Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: yellowDarken.withOpacity(0.2),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(50),
                  color: darkGreen,
                  child: IconButton(
                    onPressed: getImage,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
