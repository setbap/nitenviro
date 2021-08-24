import 'dart:io';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nitenviro/repo/repo.dart';
import 'package:nitenviro/utils/utils.dart';

class SpectialRequest extends StatefulWidget {
  final File? image;
  final FnWithOneParam<File> onSelectImage;

  const SpectialRequest({
    Key? key,
    this.image,
    required this.onSelectImage,
  }) : super(key: key);

  @override
  State<SpectialRequest> createState() => _SpectialRequestState();
}

class _SpectialRequestState extends State<SpectialRequest> {
  final ImagePicker picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final _image = File(pickedFile.path);
      widget.onSelectImage(_image);
    }
    // else {}
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
                        if (widget.image != null)
                          Image.file(
                            widget.image!,
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
