import 'package:first_app/common/message.dart';
import 'package:flutter/material.dart';
import 'package:gwslib/common/text_style.dart';
import 'package:gwslib/mold/mold.dart';
import 'package:gwslib/mold/mold_stateful_widget.dart';
import 'package:gwslib/widgets/icon.dart';
import 'package:gwslib/widgets/table.dart';
import 'package:gwslib/widgets/text.dart';

class MessageScreenWidget extends StatelessWidget {
  MessageScreenWidget(this.errorStream, {this.onCloseTap});

  final VoidCallback onCloseTap;

  final Stream<Message> errorStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Message>(
      stream: errorStream,
      builder: (_, st) {
        if (st.data?.getMessage()?.isNotEmpty == true) {
          final error = st.data;
          return MyTable.horizontal(
            [
              MyIcon.icon(
                error.icon,
                size: 20,
                padding: EdgeInsets.only(left: 16, right: 8),
                color: error.iconColor,
              ),
              MyText(
                error.getMessage(),
                style: TS_ErrorText(textColor: error.textColor),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                maxLines: 4,
                flex: 1,
              ),
              if (onCloseTap != null)
                MyIcon.icon(
                  Icons.close_rounded,
                  padding: EdgeInsets.all(8),
                  color: error.iconColor,
                  onTap: onCloseTap,
                )
            ],
            width: double.infinity,
            background: error.backgroundColor,
            crossAxisAlignment: CrossAxisAlignment.center,
            onTapCallback: () => showErrorDialog(context, error.getMessage()),
          );
        }
        return Container();
      },
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: MyText(message, style: TS_ErrorText(fontSize: 14.0)),
        actions: <Widget>[
          TextButton(
            child: MyText("OK", style: TS_Button()),
            onPressed: () => Mold.onContextBackPressed(context),
          )
        ],
      ),
    );
  }
}

class GLNotification extends MoldStatefulWidget {
  GLNotification(this.messageStream, {this.onCloseTap});

  final VoidCallback onCloseTap;

  final Stream<Message> messageStream;

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: MyText(message, style: TS_ErrorText(fontSize: 14.0)),
        actions: <Widget>[
          TextButton(
            child: MyText("OK", style: TS_Button()),
            onPressed: () => Mold.onContextBackPressed(context),
          )
        ],
      ),
    );
  }

  @override
  Widget onCreateWidget(BuildContext context) {
    return StreamBuilder<Message>(
      stream: messageStream,
      builder: (_, st) {
        if (st.data?.getMessage()?.isNotEmpty == true) {
          final message = st.data;
          return MyTable.horizontal(
            [
              MyIcon.icon(
                message.icon,
                size: 20,
                padding: EdgeInsets.only(left: 16, right: 8),
                color: message.iconColor,
              ),
              MyText(
                message.getMessage(),
                style: TS_ErrorText(textColor: message.textColor),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                maxLines: 4,
                flex: 1,
              ),
              if (onCloseTap != null)
                MyIcon.icon(
                  Icons.close_rounded,
                  padding: EdgeInsets.all(8),
                  color: message.iconColor,
                  onTap: onCloseTap,
                )
            ],
            width: double.infinity,
            background: message.backgroundColor,
            crossAxisAlignment: CrossAxisAlignment.center,
            onTapCallback: () => showErrorDialog(context, message.getMessage()),
          );
        }
        return Container();
      },
    );
  }
}
