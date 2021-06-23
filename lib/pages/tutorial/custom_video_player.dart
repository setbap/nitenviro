import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NEVideoPlayer extends StatefulWidget {
  final String placeholderVideoImageUrl;
  final String videoUrl;

  const NEVideoPlayer({
    Key? key,
    required this.placeholderVideoImageUrl,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _NEVideoPlayerState createState() => _NEVideoPlayerState();
}

class _NEVideoPlayerState extends State<NEVideoPlayer> {
  late final BetterPlayerConfiguration _betterPlayerConfiguration;
  late final BetterPlayerController _betterPlayerController;
  @override
  void initState() {
    super.initState();
    _betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableSubtitles: false,
        enableOverflowMenu: false,
        enableSkips: false,
      ),
      placeholder: CachedNetworkImage(
        imageUrl: widget.placeholderVideoImageUrl,
        color: Colors.black54,
        colorBlendMode: BlendMode.darken,
        fit: BoxFit.cover,
      ),
    );
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(
      _betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose(forceDispose: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: _betterPlayerController,
      key: ValueKey(widget.placeholderVideoImageUrl),
    );
  }
}
