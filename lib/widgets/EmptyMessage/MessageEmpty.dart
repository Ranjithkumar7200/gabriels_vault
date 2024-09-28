// ignore_for_file: sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:gabriels_vault/screens/constant/ColorsPalette.dart';

class MessageEmpty extends StatefulWidget {
  const MessageEmpty({super.key});

  @override
  _MessageEmptyState createState() => _MessageEmptyState();
}

class _MessageEmptyState extends State<MessageEmpty>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); 
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.66,
              child: Image.asset(
                'assets/images/empty.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Start creating new messages here!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
            FadeTransition(
              opacity: _opacity,
              child: const Text(
                'Click here to create new Messages.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _opacity,
              child: const Icon(
                Icons.arrow_downward,
                size: 40,
                color: ColorsPalette.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
