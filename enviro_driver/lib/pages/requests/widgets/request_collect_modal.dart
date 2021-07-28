import 'dart:io';

import 'package:enviro_driver/repo/repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class RequestCollectModal extends StatefulWidget {
  const RequestCollectModal({
    Key? key,
  }) : super(key: key);
  final String galss = "وزن شیشه";

  final String metal = "وزن فلز";

  final String plastic = "وزن پلاستیک";

  final String paper = "وزن کاغذ";

  final String mix = "وزن مخلوط";

  final String hint = "وزن به کیلوگرم مثلا 2.4";

  @override
  State<RequestCollectModal> createState() => _RequestCollectModalState();
}

class _RequestCollectModalState extends State<RequestCollectModal> {
  File? _image;
  final picker = ImagePicker();
  late final TextEditingController glassController;
  late final TextEditingController metalController;
  late final TextEditingController plasticController;
  late final TextEditingController paperController;
  late final TextEditingController mixController;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
      // else {}
    });
  }

  @override
  void initState() {
    glassController = TextEditingController();
    metalController = TextEditingController();
    plasticController = TextEditingController();
    paperController = TextEditingController();
    mixController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          NERequestTitle(
            title: widget.galss,
          ),
          SizedBox(
            height: 65,
            child: NETextField(
              hint: widget.hint,
              textEditingController: TextEditingController(),
            ),
          ),
          NERequestTitle(
            title: widget.metal,
          ),
          SizedBox(
            height: 65,
            child: NETextField(
              hint: widget.hint,
              textEditingController: metalController,
            ),
          ),
          NERequestTitle(
            title: widget.paper,
          ),
          SizedBox(
            height: 65,
            child: NETextField(
              hint: widget.hint,
              textEditingController: paperController,
            ),
          ),
          NERequestTitle(
            title: widget.plastic,
          ),
          SizedBox(
            height: 65,
            child: NETextField(
              hint: widget.hint,
              textEditingController: plasticController,
            ),
          ),
          NERequestTitle(
            title: widget.mix,
          ),
          SizedBox(
            height: 65,
            child: NETextField(
              hint: widget.hint,
              textEditingController: mixController,
            ),
          ),

          // ----- aaaa --------- //

          const SizedBox(height: 8),
          const NERequestTitle(
            title: "توضیحات",
          ),

          SizedBox(
            height: 56,
            child: NETextField(
              hint: "توضیحات اضافی",
              error: null,
              textEditingController: TextEditingController(),
            ),
          ),
          Container(
            decoration: DottedDecoration(
              shape: Shape.box,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
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

          const SizedBox(
            height: 24,
          ),

          Text(
            "* وارد کردن یکی از موارد مخلوط, شیشه, فلز, کاغذ یا پلاستیک ضروریست.",
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
          ),

          const SizedBox(
            height: 16,
          ),

          // ----- aaaa --------- //

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: darkGreen.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: darkGreen,
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (metalController.text.isEmpty &&
                  paperController.text.isEmpty &&
                  plasticController.text.isEmpty &&
                  mixController.text.isEmpty &&
                  glassController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "وارد کردن یکی از موارد مخلوط, شیشه, فلز, کاغذ یا پلاستیک ضروریست.",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "ثبت نهایی",
                style: TextStyle(
                  fontSize: 20,
                  color: darkGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
