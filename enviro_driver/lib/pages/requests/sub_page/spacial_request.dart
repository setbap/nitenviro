// import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpacialRequest extends StatefulWidget {
  const SpacialRequest({Key? key}) : super(key: key);

  @override
  State<SpacialRequest> createState() => _SpacialRequestState();
}

class _SpacialRequestState extends State<SpacialRequest>
    with AutomaticKeepAliveClientMixin<SpacialRequest> {
  @override
  void initState() {
    super.initState();
    context.read<TodaySpacialRequestCubit>().getTodaySpacialRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<TodaySpacialRequestCubit>().getTodaySpacialRequest();
      },
      child: BlocConsumer<TodaySpacialRequestCubit, TodaySpacialRequestState>(
        listener: (context, state) {
          if (state.spacialRequest.isNotEmpty) {
            if (state is TodaySpacialRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          }

          if (state is TodaySpacialRequestLoading && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          // when first request goes wrong or loading state
          if (state.spacialRequest.isEmpty) {
            if (state is TodaySpacialRequestLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 32,
                    ),
                    Text("درحال دریافت درخواست های ویژه امروز")
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (state is TodaySpacialRequestError)
                          ? "خطا در دریافت"
                          : "درخواست ویژه ای موجود نیست",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (state is TodaySpacialRequestError)
                      const SizedBox(height: 32),
                    if (state is TodaySpacialRequestError)
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    const SizedBox(height: 32),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<TodaySpacialRequestCubit>()
                            .getTodaySpacialRequest();
                      },
                      child: Text(
                        "تلاش دوباره",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          // in this state today building fetched successfully

          return ListView.builder(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 72),
            // physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final spacialReq = state.spacialRequest[index];
              final building = spacialReq.building;
              return RequestItemCard(
                detailBTNText: "مشاهده جزییات",
                acceptBTNText: "آغاز فرآیند دریافت",
                time: "کل روز",
                address: building.address,
                onDetailPress: () {
                  showAvatarModalBottomSheet(
                    builder: (context) {
                      return RequestCardDetailModal(
                        lat: building.latitude,
                        isSpecial: true,
                        plak: building.plaque,
                        postalCode: building.postalCode,
                        lng: building.longitude,
                        address: building.address,
                        desc: ((spacialReq.specialDescription ?? "").isEmpty)
                            ? "توضیحاتی درج نشده است"
                            : spacialReq.specialDescription,
                        time: "کل روز",
                        imageUrl: spacialReq.specialImageUrl ?? "",
                      );
                    },
                    name: building.user?.name ?? "",
                    context: context,
                    avatarUrl: building.user?.avatar,
                  );
                },
                onAcceptPress: state is TodaySpacialRequestLoading
                    ? null
                    : () async {
                        final isSuccess = await context
                            .read<TodaySpacialRequestCubit>()
                            .setRequestToOngoing(
                              id: spacialReq.id,
                              driverMessage: "",
                            );
                        if (isSuccess != null && isSuccess) {
                          context
                              .read<AcceptedRequestCubit>()
                              .getAcceptedRequest();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("درخواست به لیست در حال اجرا اضافه شد"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                isSpectial: state.spacialRequest[index].isSpecial,
              );
            },
            itemCount: state.spacialRequest.length,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
