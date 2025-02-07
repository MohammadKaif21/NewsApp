import 'package:flutter_application/Components/rubik_text_styles.dart';
import 'package:flutter_application/Utilities/common_enums.dart';
import 'package:flutter_application/Utilities/local_images.dart';
import 'package:flutter/material.dart';

class ShowNoDataScreen extends StatelessWidget {
  final bool on;
  final Widget child;
  final bool showAsCell;
  final VoidCallback onTryAgain;
  const ShowNoDataScreen({super.key, required this.child, required this.on, this.showAsCell = false, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return on ? _NoDataFoundScreen(showAsCell: showAsCell, onTryAgain: onTryAgain) : child;
  }
}

class _NoDataFoundScreen extends StatelessWidget {
  final bool showAsCell;
  final VoidCallback onTryAgain;
  const _NoDataFoundScreen({this.showAsCell = false, required this.onTryAgain});

  @override
  Widget build(BuildContext context) {
    return showAsCell ? noDataWidget(context) : SizedBox(height: MediaQuery.of(context).size.height * 0.75, child: noDataWidget(context));
  }

  Padding noDataWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(LocalImages.noData, width: 150, height: 150),
            const Label(text: "No Data Found", fontSize: 16, align: TextAlign.center, textColor: Colors.black, style: TextStyleType.medium),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onTryAgain,
              child: const Label(text: "Retry", fontSize: 16, align: TextAlign.center, textColor: Colors.black, style: TextStyleType.regular),
            ),
          ],
        ),
      ),
    );
  }
}
