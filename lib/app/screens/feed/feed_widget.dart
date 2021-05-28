import 'package:flutter/material.dart';
import 'package:social/app/screens/feed/components/post_body_widget.dart';
import 'package:social/app/screens/feed/components/user_title_widget.dart';
import 'package:social/app/screens/feed/feed_bloc.dart';
import 'package:social/app/screens/feed/feed_module.dart';
import 'package:social/app/shared/models/post.dart';

class FeedWidget extends StatelessWidget {

  late final FeedBloc _bloc = FeedModule.to.getBloc<FeedBloc>();

  Widget _postTitle(Post post) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      UserTitleWidget(post.user!),
      SizedBox(height: 8),
      Text(post.title),
      SizedBox(height: 24),
    ],
  );

  @override
  Widget build(BuildContext context) {
    _bloc.doFetch();
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: StreamBuilder(
        stream: _bloc.posts,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data!;
            return ListView.separated(
              itemCount: posts.length,
              itemBuilder: (_, index) {
                final post = posts[index];
                return ListTile(
                  title: _postTitle(post),
                  subtitle: PostBodyWidget(post),
                );
              },
              separatorBuilder: (_, __) => Divider(),
            );
          }

          return StreamBuilder(
            stream: _bloc.loading,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              final loading = snapshot.data ?? false;
              if (loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}
