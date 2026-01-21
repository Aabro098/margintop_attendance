// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class CheckoutDetails extends StatefulWidget {
  const CheckoutDetails({super.key});

  @override
  State<CheckoutDetails> createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
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

  Future<void> _checkOut() async {
    final details = _getString();
    if (details.isEmpty) {
      showErrorSnackbar(
        "Your work details cannot be empty.",
      );
      return;
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final response = await AttendanceServices().checkOut(
        context: context,
        workSummary: details,
      );
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showSuccessSnackbar(
            "Check out successfull. Hope you had a wonderful day workmate.",
          );
          Navigator.pop(context);
        } else {
          showErrorSnackbar(
            response['message'],
          );
        }
      } else {
        showErrorSnackbar(
          AppStrings.error,
        );
      }
    } catch (e) {
      showErrorSnackbar(
        AppStrings.error,
      );
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
        title: const AutoSizeText("Check Out"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              QuillSimpleToolbar(
                controller: _controller,
                config: const QuillSimpleToolbarConfig(
                  showAlignmentButtons: false,
                  showBackgroundColorButton: false,
                  showCodeBlock: false,
                  showColorButton: false,
                  showDirection: false,
                  showDividers: false,
                  showFontFamily: false,
                  showInlineCode: false,
                  showIndent: false,
                  showLink: false,
                  showSearchButton: false,
                  showStrikeThrough: false,
                  showListCheck: false,
                  showQuote: false,
                  showSubscript: false,
                  showSuperscript: false,
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
                    placeholder: "Tell us about your day...",
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppSizes.sm,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _checkOut();
                  },
                  child: const Text(
                    "Check Out",
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
