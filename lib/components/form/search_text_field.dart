import 'package:flutter/material.dart';

import '../../styles/form/form_border_side.dart';
import '../../styles/radiuses.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final String? hintText;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Iterable<String>? autoFill;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final bool? isOptional;
  final bool? isFieldDisable;
  final Function? onFieldTap;

  const SearchTextField({
    Key? key,
    required this.controller,
    this.maxLines,
    this.hintText,
    required this.inputType,
    this.onSubmitted,
    this.maxLength,
    this.prefixIcon,
    this.isOptional,
    this.suffixIcon,
    this.onChanged,
    this.autoFill,
    this.focusNode,
    this.isFieldDisable = false,
    this.onFieldTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isFieldDisable == true) {
      return GestureDetector(
        onTap: () => onFieldTap?.call(),
        child: AbsorbPointer(
          child: IgnorePointer(
            ignoring: true,
            child: _searchBar(),
          ),
        ),
      );
    }
    return _searchBar();
  }

  Widget _searchBar() => TextFormField(
    showCursor: true,
    focusNode: focusNode,
    controller: controller,
    keyboardType: inputType,
    onChanged: onChanged,
    maxLines: maxLines,
    maxLength: maxLength,
    onFieldSubmitted: onSubmitted,
    cursorColor: Colors.black45,
    autofillHints: autoFill,
    validator: null,
    decoration: InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      fillColor: Colors.white,
      filled: true,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: AppBorderRadius.radius10,
        borderSide: FormBorderSide.none,
      ),

      hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
    ),
  );
}
