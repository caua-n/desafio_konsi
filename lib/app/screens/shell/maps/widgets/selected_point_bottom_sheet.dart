import 'package:flutter/material.dart';

void showSelectedPoint(
  BuildContext context,
  String title,
  String description,
  VoidCallback callback,
) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return SelectedPointBottomSheet(
        title: title,
        description: description,
        callback: callback,
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
          const SizedBox(height: 16),
          Text(description),
          const Spacer(),
          ElevatedButton(
            onPressed: callback,
            child: const Text('Salvar endereço'),
          ),
        ],
      ),
    );
  }
}
