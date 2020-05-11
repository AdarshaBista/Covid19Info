import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_bloc/podcast_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/core/models/podcast.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_card.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_controls.dart';

class PodcastList extends StatefulWidget {
  @override
  _PodcastListState createState() => _PodcastListState();
}

class _PodcastListState extends State<PodcastList> {
  double _panelOpenPercent = 0.0;
  PanelController _panelController;

  @override
  void initState() {
    super.initState();
    _panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        if (state is InitialPodcastState) {
          return const EmptyIcon();
        } else if (state is LoadedPodcastState) {
          final podcastState = state;
          return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
            builder: (context, state) {
              final double playerCollapsedHeight = 96.0;
              if (state is LoadingPodcastPlayerState) {
                return _buildBody(context, podcastState, playerCollapsedHeight, null);
              } else if (state is LoadedPodcastPlayerState) {
                return _buildBody(
                    context, podcastState, playerCollapsedHeight, state.currentPodcast);
              } else if (state is ErrorPodcastPlayerState) {
                return _buildBody(context, podcastState, 0.0, null);
              } else {
                return _buildBody(context, podcastState, 0.0, null);
              }
            },
          );
        } else if (state is ErrorPodcastState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  SlidingUpPanel _buildBody(BuildContext context, LoadedPodcastState state,
      double playerCollapsedHeight, Podcast currentPodcast) {
    return SlidingUpPanel(
      controller: _panelController,
      color: AppColors.background,
      parallaxOffset: 0.2,
      isDraggable: true,
      backdropEnabled: true,
      parallaxEnabled: true,
      backdropTapClosesPanel: true,
      slideDirection: SlideDirection.UP,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 64.0),
      borderRadius: BorderRadius.circular(12.0),
      maxHeight: MediaQuery.of(context).size.height * 0.5,
      minHeight: playerCollapsedHeight,
      onPanelSlide: (value) => setState(() {
        _panelOpenPercent = value;
      }),
      body: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: playerCollapsedHeight + 64.0),
        itemCount: state.podcasts.length,
        itemBuilder: (_, index) {
          return PodcastCard(
            podcast: state.podcasts[index],
            color: AppColors.accentColors[index % AppColors.accentColors.length],
            isPlaying: currentPodcast != null && currentPodcast == state.podcasts[index],
          );
        },
      ),
      collapsed: _builMinimizedPlayer(),
      panel: Transform.scale(
        scale: _panelOpenPercent,
        child: _buildPlayer(),
      ),
    );
  }

  _builMinimizedPlayer() {
    return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
      builder: (context, state) {
        if (state is LoadingPodcastPlayerState) {
          return const BusyIndicator();
        } else if (state is LoadedPodcastPlayerState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildImage(state.currentPodcast.imageUrl),
                const SizedBox(width: 8.0),
                _buildTitle(state.currentPodcast.title.trim()),
                const SizedBox(width: 8.0),
                _buildPlayPauseIcon(context, state.isPlaying),
                const SizedBox(width: 8.0),
                _buildCloseIcon(context),
              ],
            ),
          );
        } else if (state is ErrorPodcastPlayerState) {
          return const ErrorIcon();
        } else {
          return const ErrorIcon();
        }
      },
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

  Widget _buildPlayPauseIcon(BuildContext context, bool isPlaying) {
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
      ),
    );
  }

  Widget _buildCloseIcon(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: () => context.bloc<PodcastPlayerBloc>()..add(StopPodcastEvent()),
      child: Icon(
        Icons.close,
        size: 28.0,
      ),
    );
  }

  Widget _buildPlayer() {
    return BlocBuilder<PodcastPlayerBloc, PodcastPlayerState>(
      builder: (context, state) {
        if (state is LoadingPodcastPlayerState) {
          return const BusyIndicator();
        } else if (state is LoadedPodcastPlayerState) {
          return PodcastControls(state: state);
        } else if (state is ErrorPodcastPlayerState) {
          return const ErrorIcon();
        } else {
          _panelController.hide();
          return const Offstage();
        }
      },
    );
  }
}
