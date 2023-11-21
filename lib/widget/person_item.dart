import 'package:flutter/material.dart';

class PersonItem extends StatelessWidget {
  const PersonItem({super.key, required this.title, required this.content});

  final String title, content;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium!.copyWith(
          fontWeight: FontWeight.bold,
          height: 2,
        );
    return RichText(
      text: TextSpan(
        text: '$title:  ',
        style: textStyle,
        children: <TextSpan>[
          TextSpan(
            text: content,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
