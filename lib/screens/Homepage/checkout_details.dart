import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/services/dio_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class CheckoutDetails extends StatefulWidget {
  final bool isAbsent;
  const CheckoutDetails({super.key, required this.isAbsent});

  @override
  State<CheckoutDetails> createState() => _CheckoutDetailsState();
}

class _CheckoutDetailsState extends State<CheckoutDetails> {
  final QuillController _controller = QuillController.basic();
  final ScrollController _scrollController = ScrollController();

  String _getString() {
    final doc = _controller.document;
    final delta = doc.toDelta();
    final converter = QuillDeltaToHtmlConverter(delta.toJson());
    final html = converter.convert();
    return html;
  }

  Future<void> _submit() async {
    final details = _getString();
    if (details.trim().isEmpty) {
      showErrorSnackbar("Please provide the details.");
      return;
    }
    try {
      if (widget.isAbsent) {
        await context.read<AttendanceProvider>().userAbsent(details);
      } else {
        await context.read<AttendanceProvider>().userCheckOut(details);
      }
      showSuccessSnackbar(
        widget.isAbsent
            ? "Absent marked successfully."
            : "Check out successful. Hope you had a wonderful day.",
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      showErrorSnackbar(errorMessage);
      return;
    } catch (e) {
      showErrorSnackbar(AppStrings.error);
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAbsent = widget.isAbsent;
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(isAbsent ? "Absent" : "Check Out"),
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
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                  border: Border.all(width: 2, color: Colors.grey),
                ),
                child: QuillEditor(
                  controller: _controller,
                  config: const QuillEditorConfig(
                    placeholder: "Please provide the description here...",
                  ),
                  focusNode: FocusNode(),
                  scrollController: _scrollController,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Consumer<AttendanceProvider>(
                  builder: (context, attendanceProvider, child) {
                return SizedBox(
                  width: 236,
                  child: CustomElevatedButton(
                    color: context.colorScheme.error,
                    isLoading: attendanceProvider.isLoading,
                    onPressed: () async => await _submit(),
                    label: isAbsent ? "Absent" : "Check Out",
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
