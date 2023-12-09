import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/icons.dart';
import '../../styles/text_styles/tt_commons_text_styles.dart';
import '../asset_image_view.dart';

class BasicFormLabel extends StatelessWidget {
  final String text;
  final bool? isMandatory;

  const BasicFormLabel({Key? key, required this.text, this.isMandatory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TTCommonsTextStyles.textSm.textSemiBold(),
        ),
        Visibility(
          visible: (isMandatory ?? false),
          child: const AssetImageView(fileName: GeneralIcons.asterisk, height: 10, width: 10,),
        ),
      ],
    );
  }
}
