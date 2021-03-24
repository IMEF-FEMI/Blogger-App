import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/models/blog.dart';
import 'package:blogger_app/core/services/blog_list_service.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';

class BlogListViewModel extends BaseModel {
  //BlogListViewModel states
  List<BlogPost> blogPosts = [];
  String errorMessge = "";

  final BlogListService blogListService;

  BlogListViewModel({@required this.blogListService});

  ///populate the [blogPosts] list
  Future fetchBlogPosts() async {
    setState(ViewState.Busy);

    try {
      blogPosts = await blogListService.fetchBlogPosts();
      setState(ViewState.Idle);
    } catch (e) {
      errorMessge = e.message;
      setState(ViewState.Error);
    }
  }

  ///Try to fetch the blog posts again
  Future retryFetch() async {
    return await fetchBlogPosts();
  }
}
