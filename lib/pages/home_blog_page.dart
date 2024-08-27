import 'package:auth_with_firebase/pages/add_blog_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeBlogPage extends StatefulWidget {
  const HomeBlogPage({super.key});

  @override
  State<HomeBlogPage> createState() => _HomeBlogPageState();
}

class _HomeBlogPageState extends State<HomeBlogPage> {
  List<Map<String, dynamic>> blogList = []; //

  @override
  void initState() {
    _showBlogPost();
    super.initState();
  }

  Future<void> _showBlogPost() async {
    blogList.clear(); // clear the list before fetching new data.
    final snapshot = await FirebaseFirestore.instance.collection("blogs").get();
    for (final doc in snapshot.docs) {
      blogList.add({
        'id': doc.id,
        'title': doc.data()['title'],
        'body': doc.data()['body'],
        'category': doc.data()['category'],
      });
    }
    setState(() {}); // notify the UI to update the list.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBlogPage(showBlogs: _showBlogPost),
                  ));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: blogList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Text(blogList[index]['title']),
                Text(blogList[index]['body']),
                Text(blogList[index]['category']),
              ],
            ),
          );
        },
      ),
    );
  }
}
