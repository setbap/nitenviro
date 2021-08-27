import 'dart:developer';
import 'dart:io';
import 'package:enviro_driver/logic/logic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enviro_driver/logic/receive_form/receive_form_cubit.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class RequestCollectModal extends StatefulWidget {
  final String id;
  const RequestCollectModal({Key? key, required this.id}) : super(key: key);
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
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      // maxHeight: 900 * 2,
      // maxWidth: 1600 * 2,
      // imageQuality: 50,
    );
    if (pickedFile != null) {
      final _image = File(pickedFile.path);
      context.read<ReceiveFormCubit>().changeImage(_image);
    }
  }

  late final TextEditingController descEditingController;
  @override
  void initState() {
    descEditingController = TextEditingController();
    context.read<ReceiveFormCubit>().resetData();
    super.initState();
  }

  @override
  void dispose() {
    descEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReceiveFormCubit, ReceiveFormState>(
      listener: (context, state) {
        if (state is ReceiveFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
        if (state is ReceiveFormSuccess) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) => Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            NERequestTitle(
              title: widget.galss,
            ),
            WeightItem(
              hint: widget.hint,
              onChnage: context.read<ReceiveFormCubit>().changeGlass,
            ),
            NERequestTitle(
              title: widget.metal,
            ),
            WeightItem(
              hint: widget.hint,
              onChnage: context.read<ReceiveFormCubit>().changeMetal,
            ),
            NERequestTitle(
              title: widget.paper,
            ),
            WeightItem(
              hint: widget.hint,
              onChnage: context.read<ReceiveFormCubit>().changePaper,
            ),
            NERequestTitle(
              title: widget.plastic,
            ),
            WeightItem(
              hint: widget.hint,
              onChnage: context.read<ReceiveFormCubit>().changePlastic,
            ),
            NERequestTitle(
              title: widget.mix,
            ),
            WeightItem(
              hint: widget.hint,
              onChnage: context.read<ReceiveFormCubit>().changeMix,
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
                textEditingController: descEditingController,
              ),
            ),

            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: state.receiveFromModel.spectialImage != null
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              secondChild: const SizedBox(),
              firstChild: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: () {
                    context.read<ReceiveFormCubit>().removeImage();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("پاک کردن تصویر"),
                  ),
                ),
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
                            if (state.receiveFromModel.spectialImage != null)
                              Image.file(
                                state.receiveFromModel.spectialImage!,
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

            BlocBuilder<ReceiveFormCubit, ReceiveFormState>(
              builder: (context, state) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor:
                        (state is ReceiveFormLoading ? Colors.grey : darkGreen)
                            .withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: darkGreen,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: (state is ReceiveFormLoading)
                      ? null
                      : () {
                          context
                              .read<ReceiveFormCubit>()
                              .changeDesc(descEditingController.text);
                          context
                              .read<ReceiveFormCubit>()
                              .submitRecord(widget.id)
                              .then((isSuccessfull) => {
                                    if (isSuccessfull)
                                      {
                                        context
                                            .read<AcceptedRequestCubit>()
                                            .removeCompeletedRequest(
                                                id: widget.id)
                                      }
                                  });
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ثبت نهایی",
                      style: TextStyle(
                        fontSize: 20,
                        color: (state is ReceiveFormLoading
                            ? Colors.grey
                            : darkGreen),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class WeightItem extends StatefulWidget {
  final FnWithOneParam<double?> onChnage;
  final String hint;
  final String? initialValue;
  const WeightItem({
    Key? key,
    required this.onChnage,
    required this.hint,
    this.initialValue,
  }) : super(key: key);

  @override
  State<WeightItem> createState() => _WeightItemState();
}

class _WeightItemState extends State<WeightItem> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.initialValue)
      ..addListener(() {
        widget.onChnage(double.tryParse(textEditingController.text));
      });
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiveFormCubit, ReceiveFormState>(
      listener: (context, state) {
        if (state is ReceiveFormSuccess) {
          textEditingController.clear();
        }
      },
      child: SizedBox(
        height: 65,
        child: NETextField(
          hint: widget.hint,
          textInputAction: TextInputAction.next,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            TextInputFormatter.withFunction((oldValue, newValue) {
              try {
                final text = newValue.text;
                if (text.isNotEmpty) double.parse(text);
                return newValue;
              } catch (e) {
                log("error");
              }
              return oldValue;
            }),
          ],
          textEditingController: textEditingController,
        ),
      ),
    );
  }
}
