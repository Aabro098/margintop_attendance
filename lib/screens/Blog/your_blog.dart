import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/screens/Blog/blog_card.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class YourBlog extends StatefulWidget {
  const YourBlog({super.key});

  @override
  State<YourBlog> createState() => _YourBlogState();
}

class _YourBlogState extends State<YourBlog> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: AppSizes.xl),
            Center(
              child: AutoSizeText(
                "Your Blogs",
                overflow: TextOverflow.visible,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColorsLight.logoColor,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),
            Expanded(
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 2,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index == 1 ? 62 : AppSizes.md,
                    ),
                    child: const BlogCard(
                      title: 'pending',
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 68.0),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: theme.colorScheme.secondary,
          label: AutoSizeText(
            "Add Blog",
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
