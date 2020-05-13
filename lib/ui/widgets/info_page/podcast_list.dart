import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_bloc/podcast_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/core/models/podcast.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/podcast_card.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/podcast_player.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/min_podcast_player.dart';

class PodcastList extends StatelessWidget {
  const PodcastList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, podcastState) {
        if (podcastState is InitialPodcastState) {
          return const EmptyIcon();
        } else if (podcastState is LoadedPodcastState) {
          return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
            builder: (context, podcastPlayerState) {
              if (podcastPlayerState is LoadingPodcastPlayerState) {
                return _PodcastListBody(
                  podcasts: podcastState.podcasts,
                  playerHeight: 0.0,
                );
              } else if (podcastPlayerState is LoadedPodcastPlayerState) {
                return _PodcastListBody(
                  podcasts: podcastState.podcasts,
                  currentPodcast: podcastPlayerState.currentPodcast,
                  playerHeight: 90.0,
                );
              } else if (podcastPlayerState is ErrorPodcastPlayerState) {
                return _PodcastListBody(
                  podcasts: podcastState.podcasts,
                  playerHeight: 0.0,
                );
              } else {
                return _PodcastListBody(
                  podcasts: podcastState.podcasts,
                  playerHeight: 0.0,
                );
              }
            },
          );
        } else if (podcastState is ErrorPodcastState) {
          return ErrorIcon(message: podcastState.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }
}

class _PodcastListBody extends StatefulWidget {
  final List<Podcast> podcasts;
  final Podcast currentPodcast;
  final double playerHeight;

  const _PodcastListBody({
    @required this.podcasts,
    @required this.playerHeight,
    this.currentPodcast,
  })  : assert(podcasts != null),
        assert(playerHeight != null);

  @override
  _PodcastListBodyState createState() => _PodcastListBodyState();
}

class _PodcastListBodyState extends State<_PodcastListBody> {
  double _panelOpenPercent = 0.0;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: _panelController,
      color: AppColors.secondary,
      isDraggable: true,
      backdropEnabled: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.UP,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 70.0),
      borderRadius: BorderRadius.circular(12.0),
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      minHeight: widget.playerHeight,
      onPanelSlide: (value) => setState(() {
        _panelOpenPercent = value;
      }),
      body: _buildList(),
      collapsed: _buildMinimizedPlayer(),
      panelBuilder: (sc) => Transform.scale(
        scale: _panelOpenPercent,
        child: _buildPlayer(sc),
      ),
    );
  }

  ListView _buildList() {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.0, bottom: widget.playerHeight + 72.0),
      itemCount: widget.podcasts.length,
      itemBuilder: (_, index) {
        final podcast = widget.podcasts[index];
        return PodcastCard(
          podcast: podcast,
          color: AppColors.accentColors[index % AppColors.accentColors.length],
          isPlaying: widget.currentPodcast != null && widget.currentPodcast == podcast,
        );
      },
    );
  }

  Widget _buildMinimizedPlayer() {
    return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
      builder: (context, state) {
        if (state is LoadingPodcastPlayerState) {
          return const BusyIndicator();
        } else if (state is LoadedPodcastPlayerState) {
          return MinPodcastPlayer(state: state);
        } else if (state is ErrorPodcastPlayerState) {
          return const Offstage();
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildPlayer(ScrollController controller) {
    return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
      builder: (context, state) {
        if (state is LoadingPodcastPlayerState) {
          return const BusyIndicator();
        } else if (state is LoadedPodcastPlayerState) {
          return PodcastPlayer(
            state: state,
            controller: controller,
          );
        } else if (state is ErrorPodcastPlayerState) {
          return const ErrorIcon();
        } else {
          _panelController.close();
          return const Offstage();
        }
      },
    );
  }
}
