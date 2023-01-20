import 'package:flutter/material.dart';
import 'package:toasta/toasta.dart';

void setNotification(
  BuildContext context, {
  required String title,
  ToastStatus status = ToastStatus.info,
  String? subtitle,
}) {
  final toast = Toast(
      title: Column(
        children: [
          SizedBox(
            height: subtitle == null ? 0 : 10,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      fadeInSubtitle: false,
      subtitle: subtitle,
      status: status);
  Toasta(context).toast(toast);
}
