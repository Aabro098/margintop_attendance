// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/common/widgets/appbar_back_button.dart';
import 'package:margintop_attendance/services/attendance_services.dart';
import 'package:margintop_attendance/utils/constants/app_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/helpers/helper_functions.dart';

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
    // Get the Delta JSON
    final deltaJson = _controller.document.toDelta().toJson();

    // Convert to string to send in API
    final jsonString = jsonEncode(deltaJson);

    return jsonString;
  }

  Future<void> _checkOut() async {
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
      final response = await AttendanceServices().checkOut(
        context: context,
        workSummary: details,
      );
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showSuccessSnackbar(
            "Check out successfull. Hope you had a wonderful day workmate.",
            context: context,
          );
          Navigator.pop(context);
        } else {
          showErrorSnackbar(response['message'], context: context);
        }
      } else {
        showErrorSnackbar(AppStrings.error, context: context);
      }
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
                child: _isLoading
                    ? const LoadingIndicator()
                    : ElevatedButton(
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
