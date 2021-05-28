import 'dart:convert';

import 'package:http/http.dart';
import 'package:social/app/shared/models/post.dart';
import 'package:social/app/shared/models/user.dart';
import 'package:social/app/shared/util/constants.dart';
import 'package:social/app_module.dart';

class FeedApi {
  final _client = AppModule.to.getDependency<Client>();


  Future<List<Post>> fetchPosts() async {
    final response = await _client.get(Uri.parse('${Constants.API_BASE_URL}/posts'));
    if (response.statusCode == 200) {
      final List<dynamic> jPosts = json.decode(response.body);
      final posts = jPosts.map((jp) => Post.fromJson(jp)).toList();
      for (final p in posts) {
        final res = await _client.get(Uri.parse('${Constants.API_BASE_URL}/users/${p.userId}'));
        res.statusCode == 200 ? p.user = User.fromRawJson(res.body) : p.user = null;
      }
      return posts;
    }else {
      throw Exception('Erro ao recuperar posts. Status code: ${response.statusCode}');
    }
  }

}
