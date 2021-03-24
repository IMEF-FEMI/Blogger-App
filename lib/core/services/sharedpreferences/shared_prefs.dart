import 'dart:convert';

import 'package:blogger_app/core/models/blog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pref_keys.dart';

class SharedPrefs {
  SharedPreferences sharedPreferences;

  /// get the shared preferences for [Strings]
  Future<String> getStringSharePrefs(String key) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString(key);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  /// helper method to set shared preferences types

  Future<bool> setSharedPreferences(String key, dynamic value) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if (value is bool) return sharedPreferences.setBool(key, value);
      if (value is double) return sharedPreferences.setDouble(key, value);
      if (value is int) return sharedPreferences.setInt(key, value);
      if (value is List<String>)
        return sharedPreferences.setStringList(key, value);
      else
        return sharedPreferences.setString(key, value);
    } on Exception catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  /// get Token
  Future<String> getToken() async {
    return await getStringSharePrefs(PrefKeys.token);
  }

  /// set token
  Future setToken(String value) async {
    return await setSharedPreferences(PrefKeys.token, value);
  }

  /// get last fetched Blog posts
  Future<List<BlogPost>> getBlogPosts() async {
    final savedBlogs = await getStringSharePrefs(PrefKeys.blogPosts);
    if (savedBlogs != null)
      return (json.decode(savedBlogs) as List)
          .map((blog) => BlogPost.fromJson(blog))
          .toList();
    return null;
  }

  /// set fetched Blog posts
  Future setBlogPosts(List value) async {
    return await setSharedPreferences(PrefKeys.blogPosts, json.encode(value));
  }

  ///clear shared preferences
  Future<bool> clearSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }
}
