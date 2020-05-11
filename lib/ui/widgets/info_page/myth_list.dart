import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/myth_bloc/myth_bloc.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/info_page/info_card.dart';
import 'package:covid19_info/ui/widgets/indicators/empty_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/error_icon.dart';
import 'package:covid19_info/ui/widgets/indicators/busy_indicator.dart';

class MythList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
}
