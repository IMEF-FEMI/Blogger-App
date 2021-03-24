import 'package:blogger_app/core/models/blog.dart';
import 'package:blogger_app/ui/views/blog_fullscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogTile extends StatelessWidget {
  final BlogPost blogPost;

  const BlogTile({Key key, @required this.blogPost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BlogFullScreen(blogPost: blogPost)));
      },
      child: ListTile(
        leading: CachedNetworkImage(
          height: 50,
          width: 50,
          imageUrl: blogPost.imageUrl.replaceAll("http://", "https://"),
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
          errorWidget: (context, url, error) => Icon(
            Icons.image,
            size: 50,
            color: Colors.white,
          ),
        ),
        title: Text(
          blogPost.title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            DateFormat("dd - MM - yyyy").format(
              DateTime.parse(blogPost.createdAt),
            ),
            style: TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
        trailing: Icon(
          Icons.open_in_full,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
