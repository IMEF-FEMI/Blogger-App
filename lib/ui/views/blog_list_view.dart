import 'package:blogger_app/core/enums/view_state.dart';
import 'package:blogger_app/core/viewmodels/authentication_viewmodel.dart';
import 'package:blogger_app/core/viewmodels/blog_list_viewmodel.dart';
import 'package:blogger_app/ui/widgets/blog_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'base_view.dart';

class BlogListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthenticationViewModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Blog list",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await auth.logout();
                Navigator.pushNamed(context, "/login");
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: BaseView<BlogListViewModel>(
            onModelReady: (model) => model.fetchBlogPosts(),
            builder: (context, model, child) {
              final blogPosts = model.blogPosts;

              if (model.state == ViewState.Idle)
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return BlogTile(
                          key: Key(blogPosts[index].id),
                          blogPost: blogPosts[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.white,
                        );
                      },
                      itemCount: model.blogPosts.length),
                ));

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
                            await model.retryFetch();
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
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              );
            }),
      ),
    );
  }
}
