import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/podcast_player_data.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/podcast_player_bloc/podcast_player_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/podcast_player.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_details/mini_podcast_player.dart';

class PodcastPlayerPanel extends StatefulWidget {
  const PodcastPlayerPanel();

  @override
  _PodcastPlayerPanelState createState() => _PodcastPlayerPanelState();
}

class _PodcastPlayerPanelState extends State<PodcastPlayerPanel> {
  double panelPos = 0.0;
  PanelController panelController;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PodcastPlayerBloc, PodcastPlayerState>(
      listener: (context, state) {
        if (state is ErrorPodcastPlayerState) {
          _showErrorSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadedPodcastPlayerState) {
          return _buildPanel(state.playerState);
        } else {
          return const Offstage();
        }
      },
    );
  }

  Widget _buildPanel(PodcastPlayerData playerState) {
    return SlidingUpPanel(
      controller: panelController,
      color: AppColors.primary,
      backdropEnabled: true,
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 72.0),
      borderRadius: BorderRadius.circular(12.0),
      minHeight: 72.0,
      maxHeight: MediaQuery.of(context).size.height * 0.6,
      onPanelSlide: (value) => setState(() => panelPos = value),
      collapsed: MiniPodcastPlayer(playerState: playerState),
      panelBuilder: (sc) => Transform.scale(
        scale: panelPos,
        child: PodcastPlayer(
          controller: sc,
          playerState: playerState,
          onStop: () => panelController.close(),
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          style: AppTextStyles.smallLight,
        ),
      ),
    );
  }
}
