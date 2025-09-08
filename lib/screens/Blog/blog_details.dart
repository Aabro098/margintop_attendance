import 'package:flutter/material.dart';
import 'package:margintop_solutions/screens/Blog/blog_card.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class BlogDetails extends StatelessWidget {
  const BlogDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSizes.padding),
            child: BlogCard(
              title: 'pending',
            ),
          ),
        ),
      ),
    );
  }
}
