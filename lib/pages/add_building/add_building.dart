import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/logic/location/location_request_cubit.dart';
import 'package:nitenviro/models/location_model.dart';
import 'package:nitenviro/pages/add_building/show_map.dart';
import 'package:nitenviro/pages/new_request/widgets/reminder_time.dart';
import 'package:nitenviro/utils/colors.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:tuple/tuple.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({Key? key}) : super(key: key);

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Tuple2<TimeOfDay, TimeOfDay> timeRange = const Tuple2<TimeOfDay, TimeOfDay>(
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 21, minute: 0),
  );
  final postalCodeFormat = MaskTextInputFormatter(
    mask: '#####',
    filter: {"#": RegExp(r'[0-9]')},
  );
  final selectedDayController = TextEditingController(
    text: weekDataTuple[0].item1,
  );

  String rangeToString(Tuple2<TimeOfDay, TimeOfDay> range) {
    final start = "از ${range.item1.hour}:${range.item1.minute} ";
    final end = " تا ${range.item2.hour}:${range.item2.minute}";
    return start + end;
  }

  final selectedTimeController = TextEditingController(
    text: "12:12",
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationRequestCubit, GenericApiState<LocationModel>>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(8),
            children: [
              NEFormTextInput(
                hint: "نام (این نام صرفا جهت نمایش برای شما میباشد)",
                textInputFormatter: [],
                validator: (value) {
                  if (value == null || value == "") {
                    return "مقدار نام نمیتواند خالی باشد";
                  }
                  if (value.length < 3 || value.length > 10) {
                    return "نام باید بیشتر از 2 حرف و کمتر از 8 حرف باشد";
                  }
                },
                textEditingController: TextEditingController(),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: NEFormTextInput(
                      hint: "کد پستی (مثلا 56789-01234)",
                      textEditingController: TextEditingController(),
                      textInputFormatter: [postalCodeFormat],
                      validator: (value) {
                        if (value == null || value == "") {
                          return "مقدار کد پسیتی نمیتواند خالی باشد";
                        }
                        if (postalCodeFormat.getUnmaskedText().length != 10) {
                          return "کد پستی باید 10 رقمی باشد";
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: NEFormTextInput(
                      hint: "پلاک (مثلا 219)",
                      textEditingController: TextEditingController(),
                      textInputFormatter: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value == "") {
                          return "مقدار پلاک نمیتواند خالی باشد";
                        }

                        if (value.length > 3) {
                          return "کد پستی باید 10 رقمی باشد";
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showTimeRangePicker(
                          context: context,
                          onStartChange: (start) {
                            timeRange = timeRange.withItem1(start);
                            selectedTimeController.text =
                                rangeToString(timeRange);
                            setState(() {});
                            print("start time " + start.toString());
                          },
                          onEndChange: (end) {
                            timeRange = timeRange.withItem2(end);
                            selectedTimeController.text =
                                rangeToString(timeRange);
                            setState(() {});
                            print("end time " + end.toString());
                          },
                          interval: Duration(minutes: 15),
                          use24HourFormat: false,
                          padding: 30,
                          start: timeRange.item1,
                          end: timeRange.item2,
                          disabledTime: TimeRange(
                            startTime: TimeOfDay(hour: 21, minute: 0),
                            endTime: TimeOfDay(hour: 9, minute: 0),
                          ),
                          disabledColor: Colors.red.withOpacity(0.5),
                          strokeWidth: 4,
                          handlerRadius: 8,
                          strokeColor: yellowDarken,
                          handlerColor: yellowDarken,
                          selectedColor: mainYellow,
                          backgroundColor: Colors.white,
                          ticks: 24,
                          ticksColor: yellowSemiDarken,
                          snap: true,
                          labels: List.generate(
                            12,
                            (index) => (index * 2).toString(),
                          ).asMap().entries.map((e) {
                            return ClockLabel.fromIndex(
                              idx: e.key,
                              length: 12,
                              text: e.value,
                            );
                          }).toList(),
                          labelOffset: -30,
                          labelStyle: TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          timeTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                          activeTimeTextStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          fromText: "از",
                          toText: "تا",
                          clockRotation: 180,
                          ticksWidth: 3,
                          rotateLabels: false,
                          backgroundWidget: LayoutBuilder(
                            builder: (context, constraints) {
                              return Center(
                                child: Container(
                                  width: constraints.maxWidth / 2,
                                  child: Text(
                                    "محدوده ساعت انتخابی خود را مشخص کنید",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      child: IgnorePointer(
                        child: NEFormTextInput(
                          isReadOnly: true,
                          hint: "ساعت مراجعه",
                          showClearButton: false,
                          textEditingController: selectedTimeController,
                          textInputFormatter: [],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "مقدار روز هفته نمیتواند خالی باشد";
                            }
                            final distance =
                                (timeRange.item2.hour - timeRange.item1.hour) *
                                        60 +
                                    (timeRange.item2.minute -
                                        timeRange.item1.minute);
                            if (distance < 60) {
                              return "فاصله بیش از 1 ساعت باشد";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return NESelectList(
                              data: weekDataTuple,
                              fnWithOneParam: (value) {
                                selectedDayController.text =
                                    weekDataTuple[value].item1;
                              },
                              defualtIndex: 0,
                            );
                          },
                        );
                      },
                      child: IgnorePointer(
                        child: NEFormTextInput(
                          isReadOnly: true,
                          hint: "روز هفته (مثلا شنبه)",
                          showClearButton: false,
                          textEditingController: selectedDayController,
                          textInputFormatter: [],
                          validator: (value) {
                            if (value == null || value == "") {
                              return "مقدار پلاک نمیتواند خالی باشد";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              NEFormTextInput(
                hint: "آدرس محل دریافت (شامل شهر خیابان کوچه نام طبقه و...)",
                maxLines: 4,
                textInputFormatter: [],
                validator: (value) {
                  if (value == null || value == "") {
                    return "مقدار آدرس نمیتواند خالی باشد";
                  }
                },
                textEditingController: TextEditingController(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NEFormTextInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final List<TextInputFormatter> textInputFormatter;
  final FormFieldValidator<String> validator;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool isReadOnly;
  final bool showClearButton;

  const NEFormTextInput({
    Key? key,
    this.textEditingController,
    required this.textInputFormatter,
    required this.validator,
    required this.hint,
    this.inputType = TextInputType.text,
    this.isReadOnly = false,
    this.showClearButton = true,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: [
          TextFormField(
            controller: textEditingController,
            inputFormatters: textInputFormatter,
            autocorrect: false,
            readOnly: isReadOnly,
            keyboardType: inputType,
            maxLines: maxLines,
            textInputAction: textInputAction,
            autovalidateMode: AutovalidateMode.always,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: lightBorder,
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: darkBorder),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              focusColor: lightYellow,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mainYellow),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              hintStyle: const TextStyle(color: Colors.grey),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: mainYellow),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              errorMaxLines: 1,
            ),
          ),
          if (showClearButton)
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    child:
                        const Icon(Icons.clear, color: Colors.grey, size: 24),
                    onTap: () => textEditingController?.clear(),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
