import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:nitenviro/logic/new_request_form/new_request_cubit.dart';
import 'package:nitenviro/pages/new_request/widgets/home_item.dart';
import 'package:nitenviro/pages/new_request/widgets/n_e_request_title.dart';
import 'package:nitenviro/pages/new_request/widgets/reminder_time.dart';
import 'package:nitenviro/pages/new_request/widgets/send_button.dart';
import 'package:nitenviro/pages/new_request/widgets/simple_location.dart';
import 'package:nitenviro/pages/new_request/widgets/spectial_request.dart';
import 'package:nitenviro/pages/new_request/widgets/text_field.dart';
import 'package:nitenviro/pages/new_request/widgets/tim_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/utils/utils.dart';

class NewRequest extends StatefulWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  State<NewRequest> createState() => _NewRequestState();
}

class _NewRequestState extends State<NewRequest>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController spectialCommentController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  int selectedPage = 0;

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
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 80,
              child: NETextField(
                hint: "توضیحات",
                textEditingController: commentController,
              ),
            ),
            const NERequestTitle(
              imagePath: "assets/building.png",
              title: "انتخاب ساختمان",
            ),
            HomeItem(
              onSelect: (selectedHome) {
                requestCubit.changeBuilding(selectedHome);
              },
            ),
            const SizedBox(height: 24),
            const NERequestTitle(
              imagePath: "assets/cal.png",
              title: "زمان",
            ),
            NETimPicker(
              onConfirm: (year, month, day) {
                requestCubit.changeTime("$year-$month-$day");
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 24),
            const NERequestTitle(
              imagePath: "assets/alert.png",
              title: "یادآوری",
            ),
            NEReminderTime(
              data: weekDataTuple,
              fnWithOneParam: (int value) {
                requestCubit.changeReminer(value);
                FocusScope.of(context).unfocus();
              },
            ),
            const SizedBox(height: 24),
            const NERequestTitle(
              imagePath: "assets/location.png",
              title: "مکان",
            ),
            SimpleLocation(
              latLng: LatLng(36.37, 52.264),
            ),
            SpectialRequest(
              textEditingController: spectialCommentController,
            ),
            const SizedBox(height: 32),
            NESendButton(
              title: "ثبت درخواست",
              onTap: () {
                debugPrint(commentController.text);
                commentController.text = "";
                debugPrint(spectialCommentController.value.text);
              },
            ),
            // BlocBuilder<NewRequestCubit, CollectingRequest>(
            //   builder: (context, state) {
            //     return Text(state.toString());
            //   },
            // ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
