import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_attendance/common/widgets/appbar_back_button.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class CheckoutDetails extends StatefulWidget {
  const CheckoutDetails({super.key});

  @override
  State<CheckoutDetails> createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void _sendToApi() {
    // Get the Delta JSON
    final deltaJson = _controller.document.toDelta().toJson();

    // Convert to string to send in API
    final jsonString = jsonEncode(deltaJson);

    debugPrint(jsonString); // For debugging
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
                    _sendToApi();
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
