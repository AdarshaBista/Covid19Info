import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/core/models/podcast.dart';

import 'package:covid19_info/ui/widgets/common/tag.dart';
import 'package:covid19_info/ui/widgets/common/fade_animator.dart';
import 'package:covid19_info/ui/widgets/common/scale_animator.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_controls.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final Color color;

  const PodcastCard({
    @required this.podcast,
    @required this.color,
  })  : assert(podcast != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Card(
        color: AppColors.dark,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 8.0),
          backgroundColor: color.withOpacity(0.2),
          title: Row(
            children: [
              _buildImage(),
              const SizedBox(width: 16.0),
              _buildTitle(),
            ],
          ),
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildPlayer(),
                _buildSubTitle(),
                _buildTag(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Image.network(
        podcast.imageUrl,
        fit: BoxFit.cover,
        width: 64.0,
        height: 64.0,
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        podcast.title.trim(),
        textAlign: TextAlign.left,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.largeLightSerif,
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        podcast.summary.trim(),
        textAlign: TextAlign.justify,
        style: AppTextStyles.smallLightSerif,
      ),
    );
  }

  Widget _buildTag() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Tag(
        label: podcast.source,
        color: color,
        iconData: null,
      ),
    );
  }

  Widget _buildPlayer() {
    return BlocConsumer<PodcastPlayerBloc, PodcastPlayerState>(
      listener: (context, state) {
        if (state is ErrorPodcastPlayerState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: color,
              duration: const Duration(seconds: 1),
              content: Text(
                state.message,
                style: AppTextStyles.smallLight,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is InitialPodcastPlayerState) {
          return _buildPlayIcon(context);
        } else if (state is LoadedPodcastPlayerState) {
          return PodcastControls(state: state);
        } else if (state is ErrorPodcastPlayerState) {
          return _buildPlayIcon(context);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildPlayIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ScaleAnimator(
        child: FlatButton.icon(
          onPressed: () => context.bloc<PodcastPlayerBloc>()
            ..add(PlayPodcastEvent(
              podcast: podcast,
            )),
          icon: Icon(
            Icons.play_circle_filled,
          ),
          label: Text(
            'PLAY',
            style: AppTextStyles.mediumLight,
          ),
        ),
      ),
    );
  }
}
