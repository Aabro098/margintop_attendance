import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:margintop_solutions/common/reusables/loading_animation.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogCard extends StatefulWidget {
  const BlogCard({super.key, required this.title});
  final String title;

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  String? _html;

  @override
  void initState() {
    super.initState();
    _loadHtml();
  }

  Future<void> _loadHtml() async {
    try {
      final data = await rootBundle.loadString(
        'assets/blog_sample.html',
      );
      setState(() {
        _html = data;
      });
    } catch (e) {
      debugPrint("Failed to load HTML: $e");
      setState(() {
        _html = "<p style='color:red'>Failed to load blog content.</p>";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (_html == null) {
      return const Center(
        child: LoadingAnimation(
          height: 120,
          width: double.infinity,
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(AppSizes.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://imgs.search.brave.com/-P90np8rWj3bJ4b3pxbJrOiMf3WCfNtUGNgRLhR_Z_Y/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pMC53/cC5jb20vd2VhcmVj/dWx0LnJvY2tzL3dw/LWNvbnRlbnQvdXBs/b2Fkcy8yMDIyLzEw/L0JlYXV0aWZ1bC1Q/ZW9wbGUtcGljLTUu/anBnP3Jlc2l6ZT02/MjQsMzUxJnNzbD0x',
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.sm),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "Arbin Shrestha",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  widget.title == "pending"
                      ? AutoSizeText(
                          "Pending",
                          style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          Html(
            data: _html,
            style: {
              "body": Style(
                padding: HtmlPaddings.zero,
              ),
            },
          ),
        ],
      ),
    );
  }
}
