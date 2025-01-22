import 'package:courier_app/res.dart';
import 'package:courier_app/res/colours.dart';
import 'package:courier_app/widgets/base/texts.dart';
import 'package:flutter/material.dart';

class UpdatePasswordSuccess extends StatelessWidget {
  final String noteDesc;
  final String actionDesc;
  final VoidCallback actionOnTap;

  const UpdatePasswordSuccess({
    super.key,
    required this.noteDesc,
    required this.actionDesc,
    required this.actionOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        top: 64,
        right: 20,
      ),
      child: Column(
        children: [
          Image.asset(Res.route_guide_ok),
          const Padding(padding: EdgeInsets.only(bottom: 16)),
          Texts.normal(
            noteDesc,
            fontWeight: FontWeight.w500,
            color: Colours.okColor,
          ),
          const Padding(padding: EdgeInsets.only(bottom: 34)),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(335, 49)),
              ),
              onPressed: () {
                actionOnTap();
              },
              child: Texts.larger(actionDesc, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
