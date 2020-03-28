import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/info_bloc/info_bloc.dart';

import 'package:simple_coverflow/simple_coverflow.dart';
import 'package:covid19_info/ui/widgets/info_page/myth_card.dart';

class InfoPage extends StatefulWidget {
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
    return Scaffold(
      body: BlocBuilder<InfoBloc, InfoState>(
        builder: (context, state) {
          if (state is InitialInfoState) {
            return Container(color: Colors.deepPurple);
          } else if (state is LoadedInfoState) {
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'Myth',
                  textAlign: TextAlign.left,
                  style: AppTextStyles.extraLargeLight.copyWith(
                    fontSize: 30.0,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: CoverFlow(
                    dismissibleItems: false,
                    viewportFraction: 0.8,
                    itemCount: state.myths.length,
                    itemBuilder: (context, index) => MythCard(
                      myth: state.myths[index],
                    ),
                  ),
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.5,
                //   child: ListView.builder(
                //     itemCount: state.faqs.length,
                //     itemBuilder: (c, i) => Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Text(state.faqs[i].question),
                //     ),
                //   ),
                // ),
              ],
            );
          } else if (state is ErrorInfoState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: LinearProgressIndicator());
          }
        },
      ),
    );
  }
}
