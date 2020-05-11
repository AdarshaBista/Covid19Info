import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/common/scale_animator.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_slider.dart';

class PodcastControls extends StatelessWidget {
  final LoadedPodcastPlayerState state;

  const PodcastControls({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Divider(height: 16.0),
              PodcastSlider(state: state),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSpeedIcon(context),
                  _buildPlayIcon(context),
                  _buildStopIcon(context),
                ],
              ),
              const Divider(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayIcon(BuildContext context) {
    return _buildIcon(
      state.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
      44.0,
      () {
        if (state.isPlaying)
          context.bloc<PodcastPlayerBloc>()..add(PausePodcastEvent());
        else
          context.bloc<PodcastPlayerBloc>()..add(PlayPodcastEvent());
      },
    );
  }

  Widget _buildStopIcon(BuildContext context) {
    return _buildIcon(
      Icons.stop,
      32.0,
      () => context.bloc<PodcastPlayerBloc>()..add(StopPodcastEvent()),
    );
  }

  Widget _buildSpeedIcon(BuildContext context) {
    return _buildIcon(
      Icons.slow_motion_video,
      24.0,
      () => showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.dark,
        useRootNavigator: true,
        elevation: 8.0,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        builder: (_) => _buildSheet(context),
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

  Widget _buildIcon(IconData icon, double size, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          size: size,
        ),
      ),
    );
  }
}
