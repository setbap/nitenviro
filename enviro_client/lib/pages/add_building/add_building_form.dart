import 'package:dropdown_search/dropdown_search.dart';
import 'package:enviro_shared/enviro_shared.dart';
import 'package:enviro_shared/shared_widget/shared_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:nitenviro/logic/city_province_data/city_province_data.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';
import 'package:enviro_shared/enviro_shared.dart';
import 'package:tuple/tuple.dart';
import 'package:latlong2/latlong.dart';
import 'show_map.dart';

class AddBuildingForm extends StatefulWidget {
  final String? name;
  final String? postalCode;
  final int? plaque;
  final int? timeRange;
  final int? dayOfWeek;
  final String? address;
  final LatLng? latLng;
  final String? id;
  final String? cityName;
  final String? cityId;
  final String? provinceName;
  final String? provinceId;

  const AddBuildingForm({
    Key? key,
    this.id,
    this.name,
    this.postalCode,
    this.plaque,
    this.timeRange,
    this.dayOfWeek,
    this.address,
    this.latLng,
    this.cityName,
    this.cityId,
    this.provinceName,
    this.provinceId,
  }) : super(key: key);

  @override
  _AddBuildingFormState createState() => _AddBuildingFormState();
}

class _AddBuildingFormState extends State<AddBuildingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController postalCodeController;
  late final TextEditingController plaqueController;

  late final TextEditingController selectedDayController;
  late final TextEditingController timeRangeController;
  late final TextEditingController addressController;
  LatLng? latLng;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProvinceModel? selectedProvince;
  CityModel? selectedCity;

  InputDecoration data() {
    return const InputDecoration(
      filled: true,
      fillColor: lightBorder,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: darkBorder),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      focusColor: lightYellow,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainYellow),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      hintStyle: TextStyle(color: Colors.grey),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: mainYellow),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    selectedCity = CityModel(
      provinceId: widget.provinceId ?? "9f8ddce9-bd3d-4e79-bc94-56d6ded8bfdf",
      name: widget.cityName ?? "بابل",
      id: widget.cityId ?? "83e3b69a-3a85-4629-97f4-b7540c4433d4",
    );
    selectedProvince = ProvinceModel(
      id: widget.provinceId ?? "9f8ddce9-bd3d-4e79-bc94-56d6ded8bfdf",
      name: "مازندران",
    );

    nameController = TextEditingController(
      text: widget.name,
    );

    postalCodeController = TextEditingController(
      text: widget.postalCode,
    );
    plaqueController = TextEditingController(
      text: widget.plaque == null ? null : widget.plaque.toString(),
    );

    timeRangeController = TextEditingController(
      text: timeOfDayDataTuple[widget.timeRange ?? 0].item1,
    );

    selectedDayController = TextEditingController(
      text: weekDataTuple[widget.dayOfWeek ?? 0].item2.toString(),
    );
    addressController = TextEditingController(
      text: widget.address,
    );

    latLng = widget.latLng;
  }

  @override
  void dispose() {
    nameController.dispose();
    plaqueController.dispose();
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
          (widget.id != null || widget.name != null)
              ? "تغییر ${widget.name!}"
              : "اضافه کردن ساختمان جدید",
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
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: _scaffoldKey.currentContext!,
                          builder: (context) {
                            return NESelectList(
                              data: timeOfDayDataTuple,
                              fnWithOneParam: (value) {
                                timeRangeController.text =
                                    timeOfDayDataTuple[value].item2.toString();
                              },
                              defualtIndex: widget.dayOfWeek ?? 0,
                            );
                          },
                        );
                      },
                      child: IgnorePointer(
                        child: NEFormTextInput(
                          label: "محدوده مراجعه*",
                          hint: "محدوده مراجعه",
                          isReadOnly: true,
                          showClearButton: false,
                          textEditingController: timeRangeController,
                          textInputFormatter: const [],
                          validator: (value) {
                            if (value == null) {
                              return "محدوده مراجعه نمی تواند خالی باشد";
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
                                    weekDataTuple[value].item2.toString();
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
                      textEditingController: plaqueController,
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
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: DropdownSearch<ProvinceModel>(
                        mode: Mode.BOTTOM_SHEET,
                        showSearchBox: true,
                        label: "انتخاب استان*",
                        loadingBuilder: (context, searchEntry) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        itemAsString: (item) => item?.name ?? "",
                        onFind: (text) async {
                          final province = await context
                              .read<CityProvinceDataCubit>()
                              .getProvince();
                          return province
                              .where((element) =>
                                  element.name.contains(text ?? ""))
                              .toList();
                        },
                        dropdownSearchDecoration: data(),
                        searchFieldProps: TextFieldProps(
                          decoration: data().copyWith(
                            hintText: "مثلا مازندران",
                            labelText: "نام استان",
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                        emptyBuilder: (context, searchEntry) => const Center(
                          child: Text("استان با این مشخصات موجود نیست"),
                        ),
                        popupItemBuilder: (context, item, isSelected) => Card(
                          shadowColor: yellowDarken.withAlpha(150),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: item == selectedProvince
                                  ? yellowDarken.withAlpha(150)
                                  : Colors.transparent,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            selected: item == selectedProvince,
                            title: Text(item.name),
                          ),
                        ),
                        onChanged: (value) {
                          if (selectedProvince == null ||
                              selectedProvince!.id != value?.id) {
                            selectedCity = null;
                          }
                          selectedProvince = value;
                          setState(() {});
                        },
                        dropDownButton: const SizedBox(),
                        selectedItem: selectedProvince,
                        hint: "لطفا نام شهر را وارد کنید",
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownSearch<CityModel>(
                        mode: Mode.BOTTOM_SHEET,
                        key: ValueKey(selectedProvince?.id),
                        showSearchBox: true,
                        label: "انتخاب شهر*",
                        loadingBuilder: (context, searchEntry) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        itemAsString: (item) => item?.name ?? "",
                        onFind: (text) async {
                          final province = await context
                              .read<CityProvinceDataCubit>()
                              .getCitiesProvince(
                                provinceId: selectedProvince?.id ?? "شسیشسی",
                              );

                          return province
                              .where((element) =>
                                  element.name.contains(text ?? ""))
                              .toList();
                        },
                        dropdownSearchDecoration: data(),
                        searchFieldProps: TextFieldProps(
                          decoration: data().copyWith(
                            hintText: "مثلا محمودآباد",
                            labelText: "نام شهر",
                            prefixIcon: const Icon(Icons.search),
                          ),
                        ),
                        enabled: selectedProvince != null,
                        emptyBuilder: (context, searchEntry) => const Center(
                          child: Text("شهری با این مشخصات موجود نیست"),
                        ),
                        popupItemBuilder: (context, item, isSelected) => Card(
                          shadowColor: yellowDarken.withAlpha(150),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: item == selectedCity
                                  ? yellowDarken.withAlpha(150)
                                  : Colors.transparent,
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            selected: item == selectedCity,
                            title: Text(item.name),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCity = value;
                          });
                        },
                        dropDownButton: const SizedBox(),
                        selectedItem: selectedCity,
                        hint: "لطفا نام شهر را وارد کنید",
                      ),
                    ),
                  ],
                ),
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
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      latLng != null &&
                      selectedCity != null &&
                      selectedProvince != null) {
                    if (widget.id == null) {
                      final BuildingCreateModel b = BuildingCreateModel(
                        address: addressController.text,
                        cityId: selectedCity!.id,
                        description: "",
                        latitude: latLng!.latitude,
                        longitude: latLng!.longitude,
                        name: nameController.text,
                        plaque: int.tryParse(plaqueController.text) ?? 0,
                        postalCode: postalCodeController.text,
                        timeOfDay: int.tryParse(timeRangeController.text)!,
                        weekDay: int.tryParse(selectedDayController.text)!,
                      );
                      await context
                          .read<UserInfoCubit>()
                          .addUserBuilding(buildingCreateModel: b);
                    }
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
