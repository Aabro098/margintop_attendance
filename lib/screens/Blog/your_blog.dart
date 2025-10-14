import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Blog/add_blog.dart';
import 'package:margintop_solutions/screens/Blog/blog_details.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/providers/index_provider.dart';
import 'package:provider/provider.dart';

class YourBlog extends StatefulWidget {
  const YourBlog({super.key});

  @override
  State<YourBlog> createState() => _YourBlogState();
}

class _YourBlogState extends State<YourBlog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // block system back entirely
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.read<IndexProvider>().setIndex(0);
        }
      },
      child: Scaffold(
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
                  style: context.textTheme.headlineMedium?.copyWith(
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
                        bottom: index == 1 ? 62 : AppSizes.sm,
                      ),
                      child: const BlogTile(),
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const AddBlog();
                },
              ));
            },
            backgroundColor: context.colorScheme.secondary,
            label: AutoSizeText(
              "Add Blog",
              style: context.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            icon: const Icon(
              Iconsax.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const BlogDetails();
          },
        ));
      },
      child: ListTile(
        dense: true,
        tileColor: Colors.blue.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.xs,
        ),
        minVerticalPadding: AppSizes.xs,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.md),
        ),
        title: AutoSizeText(
          "Title",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: AutoSizeText(
          "This is the short description of the blog. This is written on the basis of the content of the blog. It is the provied outcome.",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(AppSizes.sm),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(AppSizes.md),
          ),
          child: AutoSizeText(
            "Pending",
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
