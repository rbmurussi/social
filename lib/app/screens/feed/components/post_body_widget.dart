import 'package:flutter/material.dart';
import 'package:social/app/shared/models/post.dart';

class PostBodyWidget extends StatelessWidget {

  final Post post;
  PostBodyWidget(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network('http://lorempixel.com.br/1280/720?post-${post.id}'),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          child: Text(post.body, style: TextStyle(fontSize: 14), textAlign: TextAlign.start),
        )
      ],
    );
  }
}
