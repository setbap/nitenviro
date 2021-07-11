import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/logic.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/recycle_open_item.dart';
import 'package:nitenviro/pages/tutorial/custom_video_player.dart';
import 'package:nitenviro/utils/utils.dart';
import 'package:public_nitenviro/public_nitenviro.dart';

class Tutorials extends StatelessWidget {
  const Tutorials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoTutorialsCubit, GenericApiState<List<PostModel>>>(
      listener: (context, state) {
        if (state.isError && !state.isLoading) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'خطا',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                ),
              ),
              content: const Text('مشکلی در ارتباط با سرور به وجود آمده است'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('بی خیال'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<VideoTutorialsCubit>().getAllTutorials();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'تلاش دوباره',
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.data == null && state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "مشکل در دریافت اطلاعات",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(
                  height: 16,
                ),
                OutlinedButton(
                  child: const Text("دریافت مجدد"),
                  onPressed: () {
                    context.read<VideoTutorialsCubit>().getAllTutorials();
                  },
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<VideoTutorialsCubit>().getAllTutorials();
          },
          child: TutorialsDataShow(data: state.data!),
        );
      },
    );
  }
}

class TutorialsDataShow extends StatelessWidget {
  final List<PostModel> data;
  const TutorialsDataShow({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              "آموزش",
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontWeight: FontWeight.w800,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [
                          blueGradient,
                          greenGradient,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(
                        const Rect.fromLTWH(0.0, 0.0, 0.0, 100.0),
                      ),
                  ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 222,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final tutItem = data[index];
                return OpenContainer(
                  openElevation: 0,
                  closedElevation: 0,
                  tappable: false,
                  closedColor: Colors.transparent,
                  openBuilder: (context, action) => OpenTutorialInfo(
                    postModel: tutItem,
                  ),
                  closedBuilder: (context, action) {
                    return Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      borderOnForeground: true,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: action,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(8),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: const LinearGradient(
                                    colors: [blueGradient, greenGradient],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://geonitenviro.nit.ac.ir/api/" +
                                          (tutItem.poster.formats.medium?.url ??
                                              tutItem.poster.url),
                                  placeholder: (context, url) => const Center(),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Container(
                              height: 28,
                              padding: const EdgeInsets.only(
                                bottom: 0,
                                top: 2,
                                right: 4,
                              ),
                              child: Text(
                                tutItem.title,
                                style: Theme.of(context).textTheme.subtitle2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: data.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 70,
          ),
        ),
      ],
    );
  }
}

class OpenTutorialInfo extends StatelessWidget {
  final PostModel postModel;

  const OpenTutorialInfo({
    Key? key,
    required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          postModel.title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: yellowDarken,
      ),
      body: Column(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: NEVideoPlayer(
                    videoUrl: "https://geonitenviro.nit.ac.ir/api/" +
                        postModel.videoUrl,
                    placeholderVideoImageUrl:
                        "https://geonitenviro.nit.ac.ir/api/" +
                            postModel.poster.url,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                InfoItemContainer(
                  borderColor: darkGreen.withOpacity(0.2),
                  child: Text(
                    postModel.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                InfoItemContainer(
                  borderColor: darkGreen.withOpacity(0.2),
                  child: Text(
                    postModel.description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
