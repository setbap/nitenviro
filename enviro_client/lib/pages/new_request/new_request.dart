import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:enviro_shared/enviro_shared.dart';
import 'package:nitenviro/models/request_model.dart';
import 'package:nitenviro/pages/new_request/widgets/widgets.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:rubbish_collectors/rubbish_collectors.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentController.addListener(() {
      log("message");
      context
          .read<NewRequestCubit>()
          .changeSpectialDescription(commentController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final requestCubit = context.read<NewRequestCubit>();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: BlocBuilder<UserInfoCubit, UserInfoState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 56,
                  child: NETextField(
                    hint: "توضیحات جمع آوری",
                    textEditingController: commentController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "این توضیحات میتواند شامل معرفی وسایل و نحوه جمع آوری و هر چیزی که به ما در جمع آوری کند، باشد",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),

                const NERequestTitle(
                  imagePath: "assets/building.png",
                  title: "انتخاب ساختمان*",
                ),
                HomeItem(
                  onSelect: (selectedHome) {
                    requestCubit
                        .changeBuilding(state.user.buildings[selectedHome].id);
                  },
                  buildings: state.user.buildings,
                ),
                // const NERequestTitle(
                //   imagePath: "assets/location.png",
                //   title: "مکان",
                // ),
                const SizedBox(height: 8),
                BlocBuilder<NewRequestCubit, CollectingRequest>(
                  buildWhen: (prev, current) =>
                      prev.selectedBuildingId != current.selectedBuildingId,
                  builder: (context, innerState) {
                    log("start");
                    Building? selectedBuilding;

                    try {
                      selectedBuilding = state.user.buildings
                          .where(
                            (element) =>
                                element.id ==
                                (innerState.selectedBuildingId ?? ""),
                          )
                          .first;
                    } catch (e) {
                      log(e.toString());
                    }

                    return AnimatedCrossFade(
                      secondChild: Container(
                        width: double.infinity,
                      ),
                      crossFadeState: selectedBuilding == null
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(
                        milliseconds: 300,
                      ),
                      firstChild: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            HeroLocationRoute(
                              builder: (context, animation) {
                                return BluredSimpleMap(
                                  lat: selectedBuilding?.latitude ?? 36.37,
                                  lng: selectedBuilding?.longitude ?? 52.264,
                                );
                              },
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          child: Hero(
                            tag: "main_simple_map_hero",
                            child: SimpleLocation(
                              key: ValueKey(selectedBuilding?.id),
                              side: RoundRediusSide.all,
                              latLng: LatLng(
                                selectedBuilding?.latitude ?? 36.37,
                                selectedBuilding?.longitude ?? 52.264,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),
                const NERequestTitle(
                  imagePath: "assets/cal.png",
                  title: "روز جمع آوری*",
                ),
                NEReminderTime(
                  data: weekDataTuple,
                  fnWithOneParam: (int value) {
                    requestCubit.changeDay(value);
                    FocusScope.of(context).unfocus();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    """
جمع آوری حداقل 48 ساعت بعد از زمان انتخاب شده صورت می پذیرد. برای مثال اگر در روز شنبه باشید و زمان انتخابی شنبه یا یک شنبه باشد
جمع آوری در هفته آینده صورت  در صورتی که با انتخاب دیگر زمان ها جمع آوری در اولین زمان ممکن انجام می شود
""",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                const SpectialRequest(),
                const SizedBox(height: 32),
                BlocBuilder<NewRequestCubit, CollectingRequest>(
                  builder: (context, innerState) {
                    debugPrint(innerState.isLoading.toString());
                    return NESendButton(
                      title: "ثبت درخواست",
                      loading: innerState.isLoading,
                      onTap: () {
                        debugPrint(commentController.text);
                        debugPrint(state.toString());
                        context
                            .read<NewRequestCubit>()
                            .changeSpectialDescription(commentController.text);
                        debugPrint(innerState.toString());
                        context.read<NewRequestCubit>().sendData(() {});
                        // commentController.text = "";
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
