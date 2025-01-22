import 'package:courier_app/api/model/dispatch_detail/reason_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../res.dart';
import '../../../res/colours.dart';
import '../../../widgets/base/texts.dart';
import '../providers/dispatch_detail_provider.dart';

class ReasonSelect extends StatefulWidget {
  final bool? defaultFold;
  final ReasonSection reasonSection;

  const ReasonSelect({
    super.key,
    this.defaultFold,
    required this.reasonSection,
  });

  @override
  State<ReasonSelect> createState() => _ReasonSelectState();
}

class _ReasonSelectState extends State<ReasonSelect> {
  late bool _fold;

  @override
  void initState() {
    _fold = widget.defaultFold ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _foldWidget(widget.reasonSection.reason ?? ''),
        Visibility(visible: _fold, child: const SizedBox(height: 12)),
        Visibility(
            visible: _fold,
            child: Wrap(
              spacing: 12,
              runSpacing: 10,
              children: <Widget>[..._widgets()],
            )),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _foldWidget(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Texts.normalMedium(title, color: Colours.titleColor),
        GestureDetector(
          onTap: () {
            setState(() {
              _fold = !_fold;
            });
          },
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Texts.normal(_fold ? 'fold' : 'unfold',
                    color: Colours.taskBussiness1),
                Image.asset(
                  _fold ? Res.fold : Res.unfold,
                  width: 18,
                  height: 18,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  List<Widget> _widgets() {
    List<Widget> list = [];
    for (int i = 0; i < widget.reasonSection.children.length; i++) {
      ReasonOption option = widget.reasonSection.children[i];
      list.add(_reasonWidget(option));
    }
    return list;
  }

  Widget _reasonWidget(ReasonOption option) {
    return Consumer(
      builder: (context, ref, _) {
        final selectedOption = ref.watch(selectedReturnReasonOptionProvider);
        bool select = false;
        String title = option.reason ?? '';
        if (selectedOption?.id == option.id) {
          select = true;
        }
        return GestureDetector(
          onTap: () {
            ref.read(selectedReturnReasonOptionProvider.notifier).state =
                option;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: select ? Colours.taskBussiness2 : Colours.greyF5,
              border: Border.all(
                  color: select ? Colours.taskBussiness1 : Colours.greyF5),
            ),
            child: Texts.normal(title,
                color: select ? Colours.taskBussiness1 : Colours.titleColor),
          ),
        );
      },
    );
  }
}
