import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key, required this.showBlogs});
  final Function showBlogs;

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final categoryController = TextEditingController();
  final sp1 = const SizedBox(height: 12);
  final sptop = const SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blog"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            sptop,
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title cannot be empty";
                }
                return null;
              },
            ),
            sp1,
            TextFormField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: "Body",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Body cannot be empty";
                }
                return null;
              },
            ),
            sp1,
            TextFormField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Category cannot be empty";
                }
                return null;
              },
            ),
            sp1,
            OutlinedButton(
              onPressed: () {
                bool isValid = formKey.currentState!.validate();
                if (!isValid) {
                  return;
                }
                _saveBlog();
              },
              child: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveBlog() async {
    final blogMap = {
      "title": titleController.text,
      "body": bodyController.text,
      "category": categoryController.text,
    };
    await FirebaseFirestore.instance.collection("blogs").add(blogMap);
    titleController.clear();
    bodyController.clear();
    categoryController.clear();
    const snackBar = SnackBar(
      content: Text('Blog successfully saved!'),
    );
    await widget
        .showBlogs(); // Call the callback function to refresh the list of blogs.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
