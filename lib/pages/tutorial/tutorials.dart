import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nitenviro/logic/generic_api_state.dart';
import 'package:nitenviro/logic/video_tutorial/video_tutorials_cubit.dart';
import 'package:nitenviro/pages/recycle_finder/widgets/recycle_open_item.dart';
import 'package:nitenviro/pages/tutorial/custom_video_player.dart';
import 'package:nitenviro/repo/public_enviro_repo.dart';
import 'package:nitenviro/utils/utils.dart';

class Tutorials extends StatelessWidget {
  const Tutorials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoTutorialsCubit,
        GenericApiState<List<TutorialItem>>>(
      listener: (context, state) {
        if (state.isError) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                'Error',
                style: TextStyle(color: Theme.of(context).primaryColor),
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
        if (state.data == null || state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return TutorialsDataShow(data: state.data!);
      },
    );
  }
}

class TutorialsDataShow extends StatelessWidget {
  final List<TutorialItem> data;
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
              crossAxisSpacing: 8,
              mainAxisSpacing: 24,
              mainAxisExtent: 212,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final tutItem = data[index];
                return OpenContainer(
                  openElevation: 0,
                  closedElevation: 0,
                  closedColor: Colors.transparent,
                  openBuilder: (context, action) => OpenTutorialInfo(
                    tutorialItem: tutItem,
                  ),
                  closedBuilder: (context, action) {
                    return InkWell(
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
                                        tutItem.image,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: Text(
                              tutItem.name,
                              style: Theme.of(context).textTheme.subtitle2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
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
  final TutorialItem tutorialItem;

  const OpenTutorialInfo({
    Key? key,
    required this.tutorialItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tutorialItem.name,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: yellowDarken,
      ),
      body: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Builder(
              builder: (context) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: NEVideoPlayer(
                    videoUrl:
                        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
                    placeholderVideoImageUrl:
                        "https://geonitenviro.nit.ac.ir/api/" +
                            tutorialItem.image,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoItemContainer(
            borderColor: darkGreen.withOpacity(0.2),
            child: Text(
              tutorialItem.name,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          InfoItemContainer(
            borderColor: darkGreen.withOpacity(0.2),
            child: Text(
              tutorialItem.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
