import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/news_bloc/news_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:simple_coverflow/simple_coverflow.dart';
import 'package:covid19_info/ui/widgets/info_page/news/news_card.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';

class NewsList extends StatelessWidget {
  const NewsList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 90.0),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is InitialNewsState) {
            return const EmptyIcon();
          } else if (state is LoadedNewsState) {
            return _buildNewsList(state);
          } else if (state is ErrorNewsState) {
            return ErrorIcon(message: state.message);
          } else {
            return const BusyIndicator();
          }
        },
      ),
    );
  }

  Widget _buildNewsList(LoadedNewsState state) {
    return CoverFlow(
      dismissibleItems: false,
      itemCount: state.news.length,
      itemBuilder: (context, index) => NewsCard(
        news: state.news[index],
        color: AppColors.accentColors[index % AppColors.accentColors.length],
      ),
    );
  }
}
