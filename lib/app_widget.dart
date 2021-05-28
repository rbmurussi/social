
import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/feed_module.dart';

class AppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData.dark(),
    home: FeedModule(),
  );
}
