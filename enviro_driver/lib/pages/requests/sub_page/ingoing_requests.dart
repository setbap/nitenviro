// import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/logic/logic.dart';
import 'package:enviro_driver/pages/requests/widgets/widgets.dart';
import 'package:enviro_driver/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IngoinRequest extends StatefulWidget {
  const IngoinRequest({Key? key}) : super(key: key);

  @override
  State<IngoinRequest> createState() => _IngoinRequestState();
}

class _IngoinRequestState extends State<IngoinRequest>
    with AutomaticKeepAliveClientMixin<IngoinRequest> {
  @override
  void initState() {
    super.initState();
    context.read<AcceptedRequestCubit>().getAcceptedRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<AcceptedRequestCubit>().getAcceptedRequest();
      },
      child: BlocConsumer<AcceptedRequestCubit, AcceptedRequestState>(
        listener: (context, state) {
          if (state.acceptedRequest.isNotEmpty) {
            if (state is AcceptedRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          }

          if (state is AcceptedRequestLoading && state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        builder: (context, state) {
          // when first request goes wrong or loading state
          if (state.acceptedRequest.isEmpty) {
            if (state is AcceptedRequestLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 32,
                    ),
                    Text("?????????? ???????????? ?????????????? ???????? ?? ?????????????? ?????? ??????????")
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      (state is AcceptedRequestError)
                          ? "?????? ???? ????????????"
                          : "?????????????? ???? ?????? ???????????? ???????? ??????????",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (state is AcceptedRequestError)
                      const SizedBox(height: 32),
                    if (state is AcceptedRequestError)
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        context
                            .read<AcceptedRequestCubit>()
                            .getAcceptedRequest();
                      },
                      child: Text(
                        "???????? ????????????",
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
              final req = state.acceptedRequest[index];
              final building = req.building;

              return RequestItemCard(
                isOngoning: true,
                detailBTNText: "????????????",
                acceptBTNText: "?????????? ????????????",
                time: req.isSpecial
                    ? "???? ??????"
                    : timeOfDayDataTuple[building.timeOfDay % 3].item1,
                phoneNumber: req.user?.phone,
                address: building.address,
                lat: building.latitude,
                lng: building.longitude,
                onDetailPress: () {
                  showAvatarModalBottomSheet(
                    builder: (context) {
                      return RequestCardDetailModal(
                        lat: building.latitude,
                        isSpecial: req.isSpecial,
                        plak: building.plaque,
                        postalCode: building.postalCode,
                        lng: building.longitude,
                        address: building.address,
                        desc: ((req.specialDescription ?? "").isEmpty)
                            ? "???????????????? ?????? ???????? ??????"
                            : req.specialDescription,
                        time: req.isSpecial
                            ? "???? ??????"
                            : timeOfDayDataTuple[building.timeOfDay % 3].item1,
                        imageUrl: req.specialImageUrl ?? "",
                      );
                    },
                    name: req.user?.name ?? "",
                    context: context,
                    avatarUrl: req.user?.avatar,
                  );
                },
                onAcceptPress: () {
                  showAvatarModalBottomSheet(
                    builder: (ctx) {
                      return RequestCollectModal(
                        id: req.id,
                      );
                    },
                    name: req.user?.name ?? "",
                    avatarUrl: req.user?.avatar ?? "",
                    useRootNavigator: false,
                    context: context,
                  );
                },
                isSpectial: req.isSpecial,
              );
            },
            itemCount: state.acceptedRequest.length,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
