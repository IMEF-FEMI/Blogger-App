import 'package:blogger_app/core/errors/exceptions.dart';
import 'package:blogger_app/core/models/blog.dart';
import 'package:blogger_app/core/services/api/endpoints.dart';
import 'package:blogger_app/core/services/sharedpreferences/shared_prefs.dart';
import 'package:flutter/foundation.dart';

import 'api/api.dart';

class BlogListService {
  final SharedPrefs _sharedPrefs;
  final Api _api;

  BlogListService({
    @required SharedPrefs sharedPrefs,
    @required Api api,
  })  : _sharedPrefs = sharedPrefs,
        _api = api;

  Future<BlogPost> fetchBlogPost(String id) async {
    final result = await _api.secureHttpGetcall(Endpoints.blog(id));
    return BlogPost.fromJson(result);
  }

  Future<List<BlogPost>> fetchBlogPosts() async {
    try {
      final result = await _api.secureHttpGetcall(Endpoints.blogs);
      // cache blogpost response
      await _sharedPrefs.setBlogPosts(result);

      return (result as List)
          .map((blogPost) => BlogPost.fromJson(blogPost))
          .toList();
    } catch (e) {
      // if there is no internet, fetch cached blog lists else returned error
      if (e is NoInternetException) {
        final result = await _sharedPrefs.getBlogPosts();
        if (result != null) return result;
        throw e;
      } else {
        throw e;
      }
    }
  }
}
