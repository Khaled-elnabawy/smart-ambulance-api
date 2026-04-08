import 'package:flutter/material.dart';
import '../../../core/widgets/back_button_widget.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackButtonWidget(),
          ],
        ),
      ),
    );
  }
}
