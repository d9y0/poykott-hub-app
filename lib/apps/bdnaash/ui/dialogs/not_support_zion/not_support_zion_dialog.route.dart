//support_zion_dialog.route
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(
  name: NotSupportZionDialog.name,
)
class NotSupportZionDialog extends ConsumerWidget {
  static const name = "Bdnaash_NotSupportZionDialogRoute";
  static const path = "/notSupportZionDialog";

  final String companyName;
  const NotSupportZionDialog({super.key, required this.companyName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.green.shade700,
      title: Text(companyName),
      content: Text(
        "لاتوجد معلومات عن هذه الشركة",
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('حسناً'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Feedback - لديك معلومات اضافية؟'),
          onPressed: () async {
            final Uri _url = Uri.parse("https://together.bdnaash.com/account?redirect=research-and-evidence");
            await launchUrl(_url);
            //
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
