import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid19_info/blocs/news_bloc/news_bloc.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.bloc<NewsBloc>()..add(GetNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is InitialNewsState) {
            return Container(color: Colors.blue);
          } else if (state is LoadedNewsState) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                return Text(state.news[index].title);
              },
            );
          } else if (state is ErrorNewsState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
