//support_zion_dialog.route
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage(
  name: SupportZionDialog.name,
)
class SupportZionDialog extends ConsumerWidget {
  static const name = "Bdnaash_SupportZionDialogRoute";
  static const path = "/supportZionDialog";
  final String companyName;
  const SupportZionDialog({super.key, required this.companyName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Colors.red.shade700,
      title: Text(companyName),
      content: const Text(
        'هذه الشركة تدعم الاحتلال الإسرائيلي',
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
      ],
    );
  }
}
