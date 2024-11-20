import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? controller;

  const SearchWidget({
    super.key,
    this.hintText = "Buscar",
    required this.keyboardType,
    this.focusNode,
    this.onChanged,
    this.onSubmit,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xffE8E8E8),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 24,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              focusNode: focusNode,
              controller: controller,
              onSubmitted: onSubmit,
              onChanged: onChanged,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: AppColors.subBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
