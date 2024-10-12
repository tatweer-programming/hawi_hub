import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hawihub/generated/l10n.dart';
import 'package:hawihub/src/core/routing/navigation_manager.dart';
import 'package:hawihub/src/core/utils/constance_manager.dart';
import 'package:hawihub/src/modules/auth/bloc/auth_bloc.dart';
import 'package:hawihub/src/modules/auth/data/models/player.dart';
import 'package:hawihub/src/modules/auth/view/widgets/auth_app_bar.dart';
import 'package:hawihub/src/modules/auth/view/widgets/widgets.dart';
import 'package:hawihub/src/modules/main/view/widgets/components.dart';
import 'package:hawihub/src/modules/payment/bloc/payment_cubit.dart';
import 'package:sizer/sizer.dart';

class MyWallet extends StatelessWidget {
  const MyWallet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    Player player = ConstantsManager.appUser!;
    String myWallet = player.myWallet.toString();
    AuthBloc bloc = context.read<AuthBloc>();
    bloc.add(GetProfileEvent(ConstantsManager.userId!, "Player"));
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Text(
          //   player.userName,
          //   style: TextStyle(
          //     fontSize: 20.sp,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    S.of(context).myWallet,
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                if (ConstantsManager.userId == player.id)
                  BlocBuilder<PaymentCubit, PaymentState>(
                    builder: (context, state) {
                      if (state is GetPaymentStatusSuccessState) {
                        bloc.add(GetProfileEvent(
                            ConstantsManager.userId!, "Player"));
                      }
                      if (state is GetProfileSuccessState) {
                        myWallet =
                            ConstantsManager.appUser!.myWallet.toString();
                      }
                      return walletWidget(() {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    controller.clear();
                                    context.pop();
                                  },
                                  child: Text(S.of(context).cancel),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                    PaymentCubit.get().addWallet(
                                        context: context,
                                        totalPrice:
                                            double.parse(controller.text));
                                    controller.clear();
                                  },
                                  child: Text(S.of(context).confirm),
                                ),
                              ],
                              title: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SubTitle(S.of(context).enterAmount),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  mainFormField(
                                    controller: controller,
                                    width: 60.w,
                                    type: TextInputType.number,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }, myWallet.toString());
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
