import 'package:flutter/material.dart';
import 'package:flutter_template/widget/loading/loading_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: ElevatedButton(
        onPressed: () {
          LoadingWidget.showLoading();
        },
        child: const Text('data'),
      ),
    );
  }
}
