import 'package:flutter/material.dart';
import 'package:hawihub/src/core/utils/color_manager.dart';
import 'package:hawihub/src/core/utils/font_manager.dart';
import 'package:hawihub/src/core/utils/styles_manager.dart';
import 'package:hawihub/src/modules/main/view/widgets/custom_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../../../generated/l10n.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              height: 33.h,
              opacity: .15,
              child: Column(
                children: [
                  SizedBox(height: 4.h,),
                  Text(S.of(context).preferenceAndPrivacy,
                    style: TextStyleManager.getTitleBoldStyle().copyWith(color: ColorManager.white),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: SingleChildScrollView(
                child: Center(
                  child: SelectableText(
                      style:
                      const TextStyle(fontWeight: FontWeightManager.medium),
                      textAlign: TextAlign.start,
                      S.of(context).questions),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}