import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:social/app/screens/feed/feed_api.dart';
import 'package:social/app/screens/feed/feed_bloc.dart';
import 'package:social/app/screens/feed/feed_widget.dart';

class FeedModule extends ModuleWidget {

  @override
  List<Bloc> get blocs => [
    Bloc((i) => FeedBloc(i.getDependency<FeedApi>())),
  ];

  @override
  Widget get view => FeedWidget();

  @override
  List<Dependency> get dependencies => [
    Dependency(_getFeedApi),
  ];

  FeedApi _getFeedApi(Inject i) {
    return FeedApi();
  }


  static Inject get to {
    return Inject<FeedModule>.of();
  }

}
