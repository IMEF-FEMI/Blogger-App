import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/models/blog.dart';
import 'package:blogger_app/core/viewmodels/single_blog_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'base_view.dart';

class BlogFullScreen extends StatelessWidget {
  final BlogPost blogPost;

  const BlogFullScreen({Key key, @required this.blogPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              blogPost.title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: BaseView<SingleBlogViewModel>(
          onModelReady: (model) => model.fetchBlogPost(blogPost.id),
          builder: (context, model, child) {
            final blog = model.blogPost;

            if (model.state == ViewState.Error)
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model.errorMessge,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                        onPressed: () async {
                          await model.retryFetch(blogPost.id);
                        },
                        child: Text("Try Again"),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                            ),
                            primary: Color(0xff62626c)))
                  ],
                ),
              );
            if (model.state == ViewState.Idle)

            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height * .3,
                    width: MediaQuery.of(context).size.height * .3,
                    imageUrl: blog.imageUrl.replaceAll("http://", "https://"),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.image,
                        size: MediaQuery.of(context).size.height * .3,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  DateFormat("dd - MM - yyyy").format(
                    DateTime.parse(blog.createdAt),
                  ),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
