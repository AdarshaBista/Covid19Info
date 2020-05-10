import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/faq_bloc/faq_bloc.dart';
import 'package:covid19_info/blocs/myth_bloc/myth_bloc.dart';
import 'package:covid19_info/blocs/podcast_bloc/podcast_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/info_page/info_card.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast_card.dart';
import 'package:covid19_info/ui/widgets/info_page/info_tab_bar.dart';
import 'package:covid19_info/ui/widgets/common/collapsible_appbar.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
            const CollapsibleAppBar(
              elevation: 0.0,
              title: 'INFO',
              imageUrl: 'assets/images/info_header.png',
            ),
            const InfoTabBar(),
          ],
          body: TabBarView(
            children: <Widget>[
              _buildMyths(),
              _buildFaqs(),
              _buildPodcasts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyths() {
    return BlocBuilder<MythBloc, MythState>(
      builder: (context, state) {
        if (state is InitialMythState) {
          return const EmptyIcon();
        } else if (state is LoadedMythState) {
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 16.0),
            itemCount: state.myths.length,
            itemBuilder: (_, index) {
              final myth = state.myths[index];
              return InfoCard(
                title: myth.myth,
                subTitle: myth.reality,
                tag: myth.sourceName,
                color: AppColors.accentColors[index % AppColors.accentColors.length],
              );
            },
          );
        } else if (state is ErrorMythState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildFaqs() {
    return BlocBuilder<FaqBloc, FaqState>(
      builder: (context, state) {
        if (state is InitialFaqState) {
          return const EmptyIcon();
        } else if (state is LoadedFaqState) {
          return ListView.separated(
            separatorBuilder: (_, __) => Divider(height: 16.0),
            itemCount: state.faqs.length,
            itemBuilder: (_, index) {
              final faq = state.faqs[index];
              return InfoCard(
                title: faq.question,
                subTitle: faq.answer,
                tag: faq.category,
                color: AppColors.accentColors[index % AppColors.accentColors.length],
              );
            },
          );
        } else if (state is ErrorFaqState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildPodcasts() {
    return BlocBuilder<PodcastBloc, PodcastState>(
      builder: (context, state) {
        if (state is InitialPodcastState) {
          return const EmptyIcon();
        } else if (state is LoadedPodcastState) {
          return ListView.builder(
            itemCount: state.podcasts.length,
            itemBuilder: (_, index) {
              return PodcastCard(
                podcast: state.podcasts[index],
                color: AppColors.accentColors[index % AppColors.accentColors.length],
              );
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
}
