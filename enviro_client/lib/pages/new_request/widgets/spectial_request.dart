import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitenviro/logic/new_request_form/new_request_cubit.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpectialRequest extends StatefulWidget {
  const SpectialRequest({
    Key? key,
  }) : super(key: key);

  @override
  SpectialRequestState createState() => SpectialRequestState();
}

class SpectialRequestState extends State<SpectialRequest> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        final requestCubit = context.read<NewRequestCubit>();
        requestCubit.changeImage(_image!);
      }
      // else {}
    });
  }

  bool showItems = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const NERequestTitle(
          imagePath: "assets/path.png",
          title: "اضافه کردن تصویر",
        ),
        Container(
          decoration: DottedDecoration(
            shape: Shape.box,
            borderRadius: BorderRadius.circular(16),
            color: darkBorder,
          ),
          child: TextButton(
            onPressed: () {
              getImage();
            },
            style: TextButton.styleFrom(
              primary: mainYellow,
            ),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_image != null)
                          Image.file(
                            _image!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/upload.png",
                              height: 56,
                            ),
                            const SizedBox(width: 24),
                            Text(
                              "آپلود تصویر",
                              style: textTheme.headline5!.copyWith(
                                color: darkGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}
