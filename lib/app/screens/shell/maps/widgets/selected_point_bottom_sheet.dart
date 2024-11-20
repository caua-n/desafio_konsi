import 'package:desafio_konsi/app/core/constants/colors.dart';
import 'package:flutter/material.dart';

void showSelectedPoint(
  BuildContext context,
  String title,
  String description,
  VoidCallback callback,
) async {
  showModalBottomSheet(
    barrierColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    elevation: 8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SelectedPointBottomSheet(
          title: title,
          description: description,
          callback: callback,
        ),
      );
    },
  );
}

class SelectedPointBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback callback;

  const SelectedPointBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                width: 32,
                height: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xffBCC0C4)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.subBlack),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: callback,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Salvar endereço',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
