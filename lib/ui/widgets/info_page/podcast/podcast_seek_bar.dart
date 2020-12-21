import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/core/models/podcast_player_data.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class PodcastSeekBar extends StatefulWidget {
  final PodcastPlayerData playerState;

  const PodcastSeekBar({
    @required this.playerState,
  }) : assert(playerState != null);

  @override
  _PodcastSeekBarState createState() => _PodcastSeekBarState();
}

class _PodcastSeekBarState extends State<PodcastSeekBar> {
  bool isSeeking = false;
  double seekValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.playerState.currentPosition,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final Duration currentDuration = snapshot.data;

          if (currentDuration.inSeconds >= widget.playerState.duration.inSeconds - 1 &&
              !isSeeking) {
            context.read<PodcastPlayerBloc>().add(const CompletedPodcastEvent());
          }

          return _buildSlider(currentDuration, context);
        }
        return const Center(
          child: CircularProgressIndicator(
            backgroundColor: AppColors.light,
          ),
        );
      },
    );
  }

  Row _buildSlider(Duration currentDuration, BuildContext context) {
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
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
            valueIndicatorColor: AppColors.light.withOpacity(0.5),
            valueIndicatorTextStyle: AppTextStyles.smallDark,
          ),
          child: Slider(
            activeColor: AppColors.light,
            inactiveColor: AppColors.light.withOpacity(0.2),
            divisions: widget.playerState.duration.inSeconds,
            max: widget.playerState.duration.inSeconds.toDouble(),
            value: isSeeking ? seekValue : currentDuration.inSeconds.toDouble(),
            label: isSeeking
                ? format(Duration(seconds: seekValue.toInt()))
                : format(currentDuration),
            onChangeStart: (_) => isSeeking = true,
            onChangeEnd: (value) {
              isSeeking = false;
              context.read<PodcastPlayerBloc>().add(SeekPodcastEvent(
                    seconds: value,
                  ));
            },
            onChanged: (value) {
              setState(() {
                seekValue = value;
              });
            },
          ),
        ),
        Text(
          format(widget.playerState.duration),
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }

  String format(Duration d) {
    final List<String> durationList = d.toString().split(':');
    durationList.last = durationList.last.split('.').first;

    if (durationList.first == '0') {
      durationList.removeAt(0);
      return durationList.join(':');
    }
    return durationList.join(':');
  }
}
