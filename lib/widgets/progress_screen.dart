import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gwslib/gwslib.dart';

class ProgressScreenWidget extends StatelessWidget {
  ProgressScreenWidget(this.progressStream);

  final Stream<bool> progressStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: progressStream,
        builder: (_, st) {
          if (st.data == true) {
            final indicatorWidget = CircularProgressIndicator(
              backgroundColor: Colors.black12,
            );
            return Container(
              child: AbsorbPointer(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Align(
                    child: MyTable(
                      [indicatorWidget],
                      borderRadius: BorderRadius.circular(8),
                      background: Colors.black87.withAlpha((255 * 0.7).toInt()),
                      padding: EdgeInsets.all(16),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
