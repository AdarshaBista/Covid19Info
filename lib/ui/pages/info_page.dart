import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/info_bloc/info_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/info_page/info_card.dart';
import 'package:covid19_info/ui/widgets/info_page/info_tab_bar.dart';
import 'package:covid19_info/ui/widgets/common/collapsible_appbar.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class InfoPage extends StatefulWidget {
  const InfoPage();

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<InfoBloc>()..add(GetInfoEvent());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            const CollapsibleAppBar(
              elevation: 0.0,
              title: 'INFORMATION',
              imageUrl: 'assets/images/info_header.png',
            ),
            const InfoTabBar(),
          ],
          body: TabBarView(
            children: <Widget>[
              _buildMyths(),
              _buildFaqs(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMyths() {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        if (state is InitialInfoState) {
          return const EmptyIcon();
        } else if (state is LoadedInfoState) {
          return ListView.builder(itemBuilder: (_, index) {
            final myth = state.myths[index];
            return InfoCard(
              title: myth.myth,
              subTitle: myth.reality,
              tag: myth.sourceName,
              color:
                  AppColors.accentColors[index % AppColors.accentColors.length],
            );
          });
        } else if (state is ErrorInfoState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }

  Widget _buildFaqs() {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        if (state is InitialInfoState) {
          return const EmptyIcon();
        } else if (state is LoadedInfoState) {
          return ListView.builder(itemBuilder: (_, index) {
            final faq = state.faqs[index];
            return InfoCard(
              title: faq.question,
              subTitle: faq.answer,
              tag: faq.category,
              color:
                  AppColors.accentColors[index % AppColors.accentColors.length],
            );
          });
        } else if (state is ErrorInfoState) {
          return ErrorIcon(message: state.message);
        } else {
          return const BusyIndicator();
        }
      },
    );
  }
}
