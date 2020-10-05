import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_bloc/podcast_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/core/models/podcast.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/podcast_card.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/podcast_player_panel.dart';

class PodcastList extends StatelessWidget {
  const PodcastList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        if (state is InitialPodcastState) {
          return const EmptyIcon();
        } else if (state is LoadedPodcastState) {
          return _buildBody(state.podcasts);
        } else if (state is ErrorPodcastState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildBody(List<Podcast> podcasts) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _buildList(podcasts),
        const PodcastPlayerPanel(),
      ],
    );
  }

  ListView _buildList(List<Podcast> podcasts) {
    return ListView.builder(
      itemCount: podcasts.length,
      padding: const EdgeInsets.only(top: 16.0, bottom: 72.0),
      itemBuilder: (_, index) {
        final podcast = podcasts[index];
        return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
          builder: (context, state) {
            bool isLoading = false;
            if (state is LoadingPodcastPlayerState) {
              isLoading = state.currentPodcast == podcast;
            }

            bool isPlaying = false;
            if (state is LoadedPodcastPlayerState) {
              isPlaying = state.playerState.currentPodcast == podcast;
            }

            return PodcastCard(
              podcast: podcast,
              color: AppColors.accentColors[index % AppColors.accentColors.length],
              isLoading: isLoading,
              isPlaying: isPlaying,
            );
          },
        );
      },
    );
  }
}
