import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nitenviro/pages/add_building/show_map.dart';
import 'package:nitenviro/pages/new_request/widgets/reminder_time.dart';
import 'package:nitenviro/pages/new_request/widgets/send_button.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:tuple/tuple.dart';
import 'package:latlong2/latlong.dart';

class AddBuildingForm extends StatefulWidget {
  final String? name;
  final String? postalCode;
  final String? pelak;
  final Tuple2<TimeOfDay, TimeOfDay>? timeRange;
  final int? dayOfWeek;
  final String? address;
  final LatLng? latLng;
  final String? id;

  const AddBuildingForm({
    Key? key,
    this.id,
    this.name,
    this.postalCode,
    this.pelak,
    this.timeRange,
    this.dayOfWeek,
    this.address,
    this.latLng,
  }) : super(key: key);

  @override
  _AddBuildingFormState createState() => _AddBuildingFormState();
}

class _AddBuildingFormState extends State<AddBuildingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController postalCodeController;
  late final TextEditingController pelakController;
  late Tuple2<TimeOfDay, TimeOfDay> timeRange;
  late final TextEditingController selectedDayController;
  late final TextEditingController timeRangeController;
  late final TextEditingController addressController;
  LatLng? latLng;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.name,
    );

    postalCodeController = TextEditingController(
      text: widget.postalCode,
    );
    pelakController = TextEditingController(
      text: widget.pelak,
    );

    timeRange = const Tuple2<TimeOfDay, TimeOfDay>(
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 21, minute: 0),
    );

    timeRangeController = TextEditingController(
      text: rangeToString(timeRange),
    );

    selectedDayController = TextEditingController(
      text: weekDataTuple[widget.dayOfWeek ?? 0].item1,
    );
    addressController = TextEditingController(
      text: widget.address,
    );

    latLng = widget.latLng;
  }

  String rangeToString(Tuple2<TimeOfDay, TimeOfDay> range) {
    final start = "از ${range.item1.hour}:${range.item1.minute} ";
    final end = " تا ${range.item2.hour}:${range.item2.minute}";
    return start + end;
  }

  @override
  void dispose() {
    nameController.dispose();
    pelakController.dispose();
    selectedDayController.dispose();
    timeRangeController.dispose();
    addressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.id != null ? "اضافه کردن ساختمان جدید" : "تغییر ساختمان موجود",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        backgroundColor: yellowDarken,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Builder(builder: (context) {
          return ListView(
            padding: const EdgeInsets.all(8),
            physics: const BouncingScrollPhysics(),
            children: [
              NEFormTextInput(
                label: "نام*",
                hint: "(این نام صرفا جهت نمایش برای شما میباشد)",
                textInputFormatter: const [],
                validator: (value) {
                  if (value == null || value == "") {
                    return "مقدار نام نمیتواند خالی باشد";
                  }
                  if (value.length < 3 || value.length > 10) {
                    return "نام باید بیشتر از 2 حرف و کمتر از 8 حرف باشد";
                  }
                },
                textEditingController: nameController,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: NEFormTextInput(
                      label: "کد پستی*",
                      hint: "(مثلا 56789-01234)",
                      textEditingController: postalCodeController,
                      textInputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (value) {
                        if (value == null || value == "") {
                          return "مقدار کد پسیتی نمیتواند خالی باشد";
                        }
                        if (value.length != 10) {
                          return "کد پستی باید 10 رقمی باشد";
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: NEFormTextInput(
                      label: "پلاک*",
                      textEditingController: pelakController,
                      hint: "(مثلا 219)",
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
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showTimeRangePicker(
                          context: _scaffoldKey.currentContext!,
                          onStartChange: (start) {
                            timeRange = timeRange.withItem1(start);
                            timeRangeController.text = rangeToString(timeRange);
                            setState(() {});
                          },
                          onEndChange: (end) {
                            timeRange = timeRange.withItem2(end);
                            timeRangeController.text = rangeToString(timeRange);
                            setState(() {});
                          },
                          interval: const Duration(minutes: 15),
                          use24HourFormat: false,
                          padding: 30,
                          start: timeRange.item1,
                          end: timeRange.item2,
                          disabledTime: TimeRange(
                            startTime: const TimeOfDay(hour: 21, minute: 0),
                            endTime: const TimeOfDay(hour: 9, minute: 0),
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
                          labelStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          timeTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                          activeTimeTextStyle: const TextStyle(
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
                                child: SizedBox(
                                  width: constraints.maxWidth / 2,
                                  child: const Text(
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
                          label: "ساعت مراجعه*",
                          hint: "ساعت مراجعه",
                          isReadOnly: true,
                          showClearButton: false,
                          textEditingController: timeRangeController,
                          textInputFormatter: const [],
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: _scaffoldKey.currentContext!,
                          builder: (context) {
                            return NESelectList(
                              data: weekDataTuple,
                              fnWithOneParam: (value) {
                                selectedDayController.text =
                                    weekDataTuple[value].item1;
                              },
                              defualtIndex: widget.dayOfWeek ?? 0,
                            );
                          },
                        );
                      },
                      child: IgnorePointer(
                        child: NEFormTextInput(
                          label: "روز هفته*",
                          isReadOnly: true,
                          hint: "(مثلا شنبه)",
                          showClearButton: false,
                          textEditingController: selectedDayController,
                          textInputFormatter: const [],
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
              const SizedBox(height: 12),
              NEFormTextInput(
                label: "آدرس محل دریافت*",
                hint: "(شامل شهر خیابان کوچه نام طبقه و...)",
                maxLines: 4,
                textInputFormatter: const [],
                validator: (value) {
                  if (value == null || value == "") {
                    return "مقدار آدرس نمیتواند خالی باشد";
                  }
                },
                textEditingController: addressController,
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                      bottom: Radius.circular(0),
                    ),
                    side: BorderSide(
                      color: darkBorder,
                      width: 2,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    _scaffoldKey.currentContext!,
                    MaterialPageRoute(
                      builder: (context) {
                        return ShowMap(
                          latLng: latLng,
                          oneItemCallBack: (latLng) {
                            setState(() {
                              this.latLng = latLng;
                            });
                          },
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_location,
                ),
                label: Text(
                  "مشخص کردن مکان روی نقشه ",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              AnimatedCrossFade(
                secondChild: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      _scaffoldKey.currentContext!,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShowMap(
                            latLng: latLng,
                            oneItemCallBack: (latLng) {
                              setState(() {
                                this.latLng = latLng;
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                        top: Radius.circular(0),
                      ),
                      border: Border.all(
                        width: 2,
                        color: darkBorder.withOpacity(0.2),
                      ),
                    ),
                    child: AbsorbPointer(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: FlutterMap(
                          key: ValueKey(latLng.toString()),
                          options: MapOptions(
                            center: latLng,
                            zoom: 17.0,
                          ),
                          layers: [
                            TileLayerOptions(
                                urlTemplate:
                                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                subdomains: ['a', 'b', 'c']),
                            MarkerLayerOptions(
                              markers: [
                                Marker(
                                  width: 40.0,
                                  height: 70.0,
                                  point: latLng ?? LatLng(36.56, 52.68),
                                  builder: (ctx) => const Padding(
                                    padding: EdgeInsets.only(bottom: 30),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 30,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                firstChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                      top: Radius.circular(0),
                    ),
                    border: Border.all(
                      width: 1,
                      color: darkBorder.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "لطفا مکان مورد نظر انتخاب کنید",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                  ),
                ),
                crossFadeState: latLng == null
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(
                  milliseconds: 400,
                ),
              ),
              const SizedBox(height: 12),
              NESendButton(
                onTap: () {
                  if (_formKey.currentState!.validate() && latLng != null) {
                    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "موفقیت در ثبت خانه",
                        ),
                        behavior: SnackBarBehavior.floating,
                        elevation: 0,
                        shape: StadiumBorder(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "ارور در ثبت خانه",
                        ),
                        behavior: SnackBarBehavior.floating,
                        elevation: 0,
                        shape: StadiumBorder(),
                      ),
                    );
                  }
                },
                title: "ثبت خانه جدید",
              ),
              const SizedBox(height: 80)
            ],
          );
        }),
      ),
    );
  }
}

class NEFormTextInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  final List<TextInputFormatter> textInputFormatter;
  final FormFieldValidator<String> validator;
  final String label;
  final String hint;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool isReadOnly;
  final bool showClearButton;
  final IconData? iconData;

  const NEFormTextInput({
    Key? key,
    this.textEditingController,
    this.iconData,
    required this.textInputFormatter,
    required this.validator,
    required this.label,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            onFieldSubmitted: (value) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.nextFocus();
              }
            },
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              prefixIcon: iconData == null ? null : Icon(iconData),
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
              left: -8,
              top: -8,
              child: SizedBox(
                width: 48,
                height: 48,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    child:
                        const Icon(Icons.clear, color: Colors.grey, size: 16),
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
