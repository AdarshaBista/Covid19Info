import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

class MinPodcastPlayer extends StatelessWidget {
  final LoadedPodcastPlayerState state;

  const MinPodcastPlayer({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            _buildImage(state.currentPodcast.imageUrl),
            const SizedBox(width: 8.0),
            _buildTitle(state.currentPodcast.title.trim()),
            const SizedBox(width: 8.0),
            _buildPlayPauseIcon(context),
            const SizedBox(width: 8.0),
            _buildCloseIcon(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 64.0,
        height: 64.0,
      ),
    );
  }

  Widget _buildTitle(title) {
    return Expanded(
      child: Text(
        title,
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.largeLightSerif,
      ),
    );
  }

  Widget _buildPlayPauseIcon(BuildContext context) {
    return StreamBuilder<bool>(
      stream: state.isPlaying,
      initialData: true,
      builder: (context, snapshot) {
        bool isPlaying = snapshot.data;
        return InkWell(
          borderRadius: BorderRadius.circular(32.0),
          onTap: () {
            if (isPlaying)
              context.bloc<PodcastPlayerBloc>()..add(PausePodcastEvent());
            else
              context.bloc<PodcastPlayerBloc>()..add(PlayPodcastEvent());
          },
          child: Icon(
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
            size: 28.0,
            color: AppColors.light,
          ),
        );
      },
    );
  }

  Widget _buildCloseIcon(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () => context.bloc<PodcastPlayerBloc>()..add(StopPodcastEvent()),
      child: Icon(
        Icons.close,
        size: 28.0,
        color: AppColors.light,
      ),
    );
  }
}
