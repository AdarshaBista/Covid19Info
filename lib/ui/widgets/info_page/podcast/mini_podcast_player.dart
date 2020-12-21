import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/podcast_player_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

class MiniPodcastPlayer extends StatelessWidget {
  final PodcastPlayerData playerState;

  const MiniPodcastPlayer({
    @required this.playerState,
  }) : assert(playerState != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Row(
        children: [
          _buildImage(playerState.currentPodcast.imageUrl),
          const SizedBox(width: 16.0),
          _buildTitle(playerState.currentPodcast.title.trim()),
          const SizedBox(width: 8.0),
          _buildPlayPauseIcon(context),
          const SizedBox(width: 8.0),
          _buildCloseIcon(context),
          const SizedBox(width: 16.0),
        ],
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 100.0,
        height: 72.0,
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.mediumLightSerif,
      ),
    );
  }

  Widget _buildPlayPauseIcon(BuildContext context) {
    return StreamBuilder<bool>(
      stream: playerState.isPlaying,
      initialData: true,
      builder: (context, snapshot) {
        final bool isPlaying = snapshot.data;
        return InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            if (isPlaying) {
              context.read<PodcastPlayerBloc>().add(const PausePodcastEvent());
            } else {
              context.read<PodcastPlayerBloc>().add(const PlayPodcastEvent());
            }
          },
          child: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 32.0,
            color: AppColors.light,
          ),
        );
      },
    );
  }

  Widget _buildCloseIcon(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () => context.read<PodcastPlayerBloc>()..add(const StopPodcastEvent()),
      child: const Icon(
        Icons.close,
        size: 28.0,
        color: AppColors.light,
      ),
    );
  }
}
