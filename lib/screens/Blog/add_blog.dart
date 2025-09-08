// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_solutions/common/reusables/shimmer.dart';
import 'package:margintop_solutions/common/widgets/appbar_back_button.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({super.key});

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  String _getString() {
    // Get document from controller
    final doc = _controller.document;

    // Convert document to Delta
    final delta = doc.toDelta();

    // Convert Delta to HTML
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();

    return html;
  }

  Future<void> _postBlog() async {
    final details = _getString();
    if (details.isEmpty) {
      showErrorSnackbar("Your work details cannot be empty.", context: context);
      return;
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      // final response = await AttendanceServices().checkOut(
      //   context: context,
      //   workSummary: details,
      // );
      // if (response != null) {
      //   if (response['message'] == "Success" && response['status'] == 1) {
      //     showSuccessSnackbar(
      //       "Check out successfull. Hope you had a wonderful day workmate.",
      //       context: context,
      //     );
      //     Navigator.pop(context);
      //   } else {
      //     showErrorSnackbar(response['message'], context: context);
      //   }
      // } else {
      //   showErrorSnackbar(AppStrings.error, context: context);
      // }
    } catch (e) {
      showErrorSnackbar(AppStrings.error, context: context);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Add Blog"),
        leading: const AppbarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              QuillSimpleToolbar(
                controller: _controller,
                config: const QuillSimpleToolbarConfig(
                  showAlignmentButtons: true,
                  showBackgroundColorButton: false,
                  showCodeBlock: false,
                  showColorButton: false,
                  showDirection: false,
                  showDividers: true,
                  showFontFamily: true,
                  showInlineCode: false,
                  showIndent: false,
                  showLink: true,
                  showSearchButton: false,
                  showStrikeThrough: true,
                  showListCheck: false,
                  showQuote: true,
                  showSubscript: true,
                  showSuperscript: true,
                  showClearFormat: false,
                ),
              ),
              const SizedBox(
                height: AppSizes.md,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.sm),
                    border: Border.all(width: 2, color: Colors.grey)),
                child: QuillEditor(
                  controller: _controller,
                  config: const QuillEditorConfig(
                    placeholder: "Add your blog...",
                  ),
                  focusNode: _focusNode,
                  scrollController: _scrollController,
                ),
              ),
              const SizedBox(
                height: AppSizes.md,
              ),
              SizedBox(
                width: 172,
                child: _isLoading
                    ? const ShimmerLoading(height: 48, width: 172)
                    : ElevatedButton(
                        onPressed: () {
                          _postBlog();
                        },
                        child: const Text(
                          "Post Blog",
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
