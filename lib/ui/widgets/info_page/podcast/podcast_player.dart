import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/core/models/podcast_player_data.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast/podcast_seek_bar.dart';

class PodcastPlayer extends StatelessWidget {
  final AsyncCallback onStop;
  final ScrollController controller;
  final PodcastPlayerData playerState;

  const PodcastPlayer({
    @required this.onStop,
    @required this.controller,
    @required this.playerState,
  })  : assert(onStop != null),
        assert(controller != null),
        assert(playerState != null);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      controller: controller,
      child: Column(
        children: [
          _buildCoverImage(),
          const SizedBox(height: 16.0),
          _buildTitle(),
          const SizedBox(height: 16.0),
          PodcastSeekBar(playerState: playerState),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SpeedIcon(playerState: playerState),
              const SizedBox(width: 4.0),
              _PlayPauseIcon(playerState: playerState),
              const SizedBox(width: 8.0),
              _StopIcon(onStop: onStop),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.network(
        playerState.currentPodcast.imageUrl,
        fit: BoxFit.cover,
        // width: 150.0,
        // height: 150.0,
        errorBuilder: (_, __, ___) => Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(
            'assets/icon/icon.png',
            fit: BoxFit.cover,
            width: 50.0,
            height: 50.0,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      playerState.currentPodcast.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: AppTextStyles.mediumLightSerif,
    );
  }
}

class _StopIcon extends StatelessWidget {
  final AsyncCallback onStop;

  const _StopIcon({
    @required this.onStop,
  }) : assert(onStop != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await onStop();
        context.read<PodcastPlayerBloc>().add(const StopPodcastEvent());
      },
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.close,
          size: 24.0,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class _PlayPauseIcon extends StatelessWidget {
  final PodcastPlayerData playerState;

  const _PlayPauseIcon({
    @required this.playerState,
  }) : assert(playerState != null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: playerState.isPlaying,
      initialData: true,
      builder: (context, snapshot) {
        final bool isPlaying = snapshot.data;
        return InkWell(
          onTap: () {
            if (isPlaying) {
              context.read<PodcastPlayerBloc>().add(const PausePodcastEvent());
            } else {
              context.read<PodcastPlayerBloc>().add(const PlayPodcastEvent());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              size: 60.0,
              color: AppColors.light,
            ),
          ),
        );
      },
    );
  }
}

class _SpeedIcon extends StatelessWidget {
  final PodcastPlayerData playerState;

  const _SpeedIcon({
    @required this.playerState,
  }) : assert(playerState != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.dark,
        useRootNavigator: true,
        elevation: 8.0,
        isDismissible: true,
        builder: (_) => _buildSheet(context),
      ),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
        ),
        child: Text(
          '${playerState.speed.toString()}x',
          style: AppTextStyles.smallDark.copyWith(
            fontSize: 12.0,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    return ListView(
      children: playerState.speedValues
          .map(
            (speed) => InkWell(
              onTap: () {
                Navigator.of(context).pop();
                context.read<PodcastPlayerBloc>().add(SetSpeedPodcastEvent(
                      speed: speed,
                    ));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    speed.toString(),
                    style: AppTextStyles.mediumLight,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
