import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/models/blog.dart';
import 'package:blogger_app/core/services/blog_list_service.dart';
import 'package:flutter/foundation.dart';
import 'base_model.dart';

class SingleBlogViewModel extends BaseModel {
  //SingleBlogViewModel states
  BlogPost blogPost;
  String errorMessge = "";

  final BlogListService blogListService;

  SingleBlogViewModel({@required this.blogListService});

  ///fetch single[BlogPost]
  Future fetchBlogPost(String id) async {
    setState(ViewState.Busy);

    try {
      blogPost = await blogListService.fetchBlogPost(id);
      setState(ViewState.Idle);
    } catch (e) {
      errorMessge = e.message;
      setState(ViewState.Error);
    }
  }

  ///Try to fetch the blog posts again
  Future retryFetch(String id) async {
    return await fetchBlogPost(id);
  }
}
