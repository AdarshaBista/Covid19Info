import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class PodcastSlider extends StatefulWidget {
  final LoadedPodcastPlayerState state;

  const PodcastSlider({
    @required this.state,
  }) : assert(state != null);

  @override
  _PodcastSliderState createState() => _PodcastSliderState();
}

class _PodcastSliderState extends State<PodcastSlider> {
  double currentValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<Duration>(
          stream: widget.state.currentDuration,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Text(
                format(snapshot.data),
                style: AppTextStyles.extraSmallLight,
              );
            return const BusyIndicator();
          },
        ),
        _buildSlider(context),
        Text(
          format(widget.state.duration),
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }

  Widget _buildSlider(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.state.currentDuration,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return Slider(
            activeColor: AppColors.light,
            inactiveColor: AppColors.light.withOpacity(0.2),
            divisions: widget.state.duration.inSeconds,
            min: 0.0,
            max: widget.state.duration.inSeconds.toDouble(),
            value: snapshot.data.inSeconds.toDouble(),
            label: format(Duration(seconds: currentValue.toInt())),
            onChanged: (value) => setState(() {
              currentValue = value;
            }),
            onChangeEnd: (value) {
              context.bloc<PodcastPlayerBloc>()
                ..add(SeekPodcastEvent(
                  seconds: value,
                ));
            },
          );
        return const BusyIndicator();
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
