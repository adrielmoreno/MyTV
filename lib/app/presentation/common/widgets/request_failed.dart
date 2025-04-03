import 'package:flutter/material.dart';

class RequestFailed extends StatelessWidget {
  const RequestFailed({super.key, required this.text, required this.onRetry});
  final String? text;
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text ?? 'Request Failed'),
          MaterialButton(
            onPressed: onRetry,
            color: Colors.blueAccent,
            child: Text('Retry'),
          )
        ],
      ),
    );
  }
}
