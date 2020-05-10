import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

class PodcastControls extends StatelessWidget {
  final LoadedPodcastPlayerState state;

  const PodcastControls({
    @required this.state,
  }) : assert(state != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: FlatButton.icon(
        onPressed: () => context.bloc<PodcastPlayerBloc>()..add(PausePodcastEvent()),
        icon: Icon(
          Icons.pause_circle_filled,
        ),
        label: Text(
          'PAUSE',
          style: AppTextStyles.mediumLight,
        ),
      ),
    );
  }
}
