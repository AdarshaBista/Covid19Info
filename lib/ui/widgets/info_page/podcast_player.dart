import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/info_page/podcast_slider.dart';

class PodcastPlayer extends StatelessWidget {
  final LoadedPodcastPlayerState state;
  final ScrollController controller;

  const PodcastPlayer({
    @required this.state,
    @required this.controller,
  })  : assert(state != null),
        assert(controller != null);

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
          PodcastSlider(state: state),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSpeedIcon(context),
              const SizedBox(width: 4.0),
              _buildPlayPauseIcon(context),
              const SizedBox(width: 8.0),
              _buildStopIcon(context),
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
        state.currentPodcast.imageUrl,
        fit: BoxFit.cover,
        width: 150,
        height: 150.0,
        errorBuilder: (_, __, ___) => Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset(
            'assets/images/error.png',
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
      state.currentPodcast.title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: AppTextStyles.mediumLightSerif,
    );
  }

  Widget _buildPlayPauseIcon(BuildContext context) {
    return StreamBuilder<bool>(
        stream: state.isPlaying,
        initialData: true,
        builder: (context, snapshot) {
          bool isPlaying = snapshot.data;
          return InkWell(
            onTap: () {
              if (isPlaying)
                context.bloc<PodcastPlayerBloc>()..add(PausePodcastEvent());
              else
                context.bloc<PodcastPlayerBloc>()..add(PlayPodcastEvent());
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
        });
  }

  Widget _buildStopIcon(BuildContext context) {
    return InkWell(
      onTap: () => context.bloc<PodcastPlayerBloc>()..add(StopPodcastEvent()),
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.stop,
          size: 24.0,
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _buildSpeedIcon(BuildContext context) {
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
        decoration: BoxDecoration(
          color: AppColors.light,
          shape: BoxShape.circle,
        ),
        child: Text(
          '${state.speed.toString()}x',
          style: AppTextStyles.smallDark.copyWith(
            fontSize: 12.0,
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }

  Widget _buildSheet(BuildContext context) {
    return ListView(
      children: state.speedValues
          .map((speed) => InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  context.bloc<PodcastPlayerBloc>()
                    ..add(SetSpeedPodcastEvent(
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
              ))
          .toList(),
    );
  }
}
