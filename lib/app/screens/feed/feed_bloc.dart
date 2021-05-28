import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:social/app/screens/feed/feed_api.dart';
import 'package:social/app/shared/models/post.dart';


class FeedBloc extends BlocBase {
  final FeedApi _api;
  FeedBloc(this._api);

  final _feedFetcher = PublishSubject<List<Post>>();
  final _loading = BehaviorSubject<bool>();

  Stream<List<Post>> get posts => _feedFetcher.stream;
  Stream<bool> get loading {
    return _loading.stream;
  }

  doFetch() async {
    _loading.sink.add(true);
    final posts = await _api.fetchPosts();
    posts.shuffle();
    _loading.sink.add(false);
    _feedFetcher.sink.add(posts);
  }



  @override
  void dispose() {
    _feedFetcher.close();
    _loading.close();
    super.dispose();
  }

}
