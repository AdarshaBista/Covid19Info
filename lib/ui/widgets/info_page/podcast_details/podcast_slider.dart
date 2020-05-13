import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class PodcastSlider extends StatelessWidget {
  final LoadedPodcastPlayerState state;

  const PodcastSlider({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: state.currentPosition,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Duration currentDuration = snapshot.data;

          if (currentDuration.inSeconds >= state.duration.inSeconds - 1) {
            context.bloc<PodcastPlayerBloc>()..add(CompletedPodcastEvent());
          }

          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                format(currentDuration),
                style: AppTextStyles.extraSmallLight,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                  valueIndicatorColor: AppColors.light.withOpacity(0.5),
                  valueIndicatorTextStyle: AppTextStyles.smallDark,
                ),
                child: Slider(
                  activeColor: AppColors.light,
                  inactiveColor: AppColors.light.withOpacity(0.2),
                  divisions: state.duration.inSeconds,
                  min: 0.0,
                  max: state.duration.inSeconds.toDouble(),
                  value: currentDuration.inSeconds.toDouble(),
                  label: format(currentDuration),
                  onChanged: (value) {
                    context.bloc<PodcastPlayerBloc>()
                      ..add(SeekPodcastEvent(
                        seconds: value,
                      ));
                  },
                ),
              ),
              Text(
                format(state.duration),
                style: AppTextStyles.extraSmallLight,
              ),
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.light,
          ),
        );
      },
    );
  }

  String format(Duration d) {
    List<String> durationList = d.toString().split(':');
    durationList.last = durationList.last.split('.').first;

    if (durationList.first == '0') {
      durationList.removeAt(0);
      return durationList.join(':');
    }
    return durationList.join(':');
  }
}
