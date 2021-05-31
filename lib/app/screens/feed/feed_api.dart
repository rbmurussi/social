import 'dart:convert';

import 'package:http/http.dart';
import 'package:social/app/screens/feed/sprint.dart';
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

  Future<List<Sprint>> getSprint() async {
    final response = await _client.get(Uri.parse('${Constants.API_SCRUM_DECK_URL}/sprint'));
    if (response.statusCode == 200) {
      final List<dynamic> jSprint = json.decode(response.body);
      final sprint = jSprint.map((jp) => Sprint.fromJson(jp)).toList();
      return sprint;
    }else {
      throw Exception('Erro ao recuperar getSprint. Status code: ${response.statusCode}');
    }
  }

  Future<List<Sprint>> getIdSprint() async {
    final response = await _client.get(Uri.parse('${Constants.API_SCRUM_DECK_URL}/sprint/:id'));
    if (response.statusCode == 200) {
      final List<dynamic> jSprint = json.decode(response.body);
      final sprint = jSprint.map((jp) => Sprint.fromJson(jp)).toList();
      return sprint;
    }else {
      throw Exception('Erro ao recuperar getIdSprint. Status code: ${response.statusCode}');
    }
  }

  Future<List<Sprint>> postSprint() async {
    final response = await _client.post(Uri.parse('${Constants.API_SCRUM_DECK_URL}/sprint'));
    if (response.statusCode == 200) {
      final List<dynamic> jSprint = json.decode(response.body);
      final sprint = jSprint.map((jp) => Sprint.fromJson(jp)).toList();
      return sprint;
    }else {
      throw Exception('Erro ao recuperar postSprint. Status code: ${response.statusCode}');
    }
  }

  Future<List<Sprint>> deleteSprint() async {
    final response = await _client.delete(Uri.parse('${Constants.API_SCRUM_DECK_URL}/sprint'));
    if (response.statusCode == 200) {
      final List<dynamic> jSprint = json.decode(response.body);
      final sprint = jSprint.map((jp) => Sprint.fromJson(jp)).toList();
      return sprint;
    }else {
      throw Exception('Erro ao recuperar postSprint. Status code: ${response.statusCode}');
    }
  }

}
