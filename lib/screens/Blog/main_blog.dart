import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/bottom_navbar.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Blog/blog_card.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/providers/drawer_provider.dart';
import 'package:provider/provider.dart';

class MainBlog extends StatefulWidget {
  const MainBlog({super.key});

  @override
  State<MainBlog> createState() => _MainBlogState();
}

class _MainBlogState extends State<MainBlog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // block system back entirely
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
          );
          context.read<DrawerProvider>().setSelectedItem('Attendance');
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
                  "Blog",
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
                        bottom: index == 1
                            ? 62
                            : AppSizes.md, // extra space for last item
                      ),
                      child: const BlogCard(
                        title: 'blog',
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
