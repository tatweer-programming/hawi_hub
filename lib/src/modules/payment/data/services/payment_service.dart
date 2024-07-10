import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hawihub/src/core/apis/api.dart';
import 'package:hawihub/src/core/apis/dio_helper.dart';
import 'package:hawihub/src/core/apis/end_points.dart';
import 'package:hawihub/src/core/utils/localization_manager.dart';
import 'package:my_fatoorah/my_fatoorah.dart';

import '../../../../core/utils/constance_manager.dart';

class PaymentService {
  Future<PaymentResponse> addWallet({
    required BuildContext context,
    required double totalPrice,
  }) async {
    return await MyFatoorah.startPayment(
      context: context,
      request: MyfatoorahRequest.test(
        currencyIso: Country.SaudiArabia,
        successUrl: ConstantsManager.successUrl,
        errorUrl: ConstantsManager.errorUrl,
        invoiceAmount: totalPrice,
        language: LocalizationManager.getCurrentLocale().languageCode == "ar"
            ? ApiLanguage.Arabic
            : ApiLanguage.English,
        token:
            "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
      ),
    );
  }

  Future<Either<String, double>> getPaymentStatus(String key) async {
    try {
      Response response = await Dio(BaseOptions(
        baseUrl: ApiManager.myFatoorahBaseUrl,
        headers: {
          "Authorization": ApiManager.myFatoorahToken,
          "Connection": "keep-alive",
        },
      )).post(EndPoints.getPaymentStatus, data: {
        "Key": key,
        "KeyType": "PaymentId",
      });
      double dueDeposit = response.data["Data"]["DueDeposit"] ?? 0.0;
      print(dueDeposit);
      await _updateWallet(ConstantsManager.appUser!.myWallet + dueDeposit);
      return Right(dueDeposit);
    } on DioException catch (e) {
      return Left(e.response.toString());
    }
  }

  Future<Either<String, String>> pendWalletBalance(double pendingWallet) async {
    try {
      await DioHelper.postData(
        path: "/Player/${ConstantsManager.userId}",
        data: {
          "pendingWallet": pendingWallet,
        },
      ).then((value) async {
        await _updateWallet(ConstantsManager.appUser!.myWallet - pendingWallet);
        await _updatePendingWallet(pendingWallet);
      });
      return const Right("Your balance has been successfully suspended");
    } on DioException catch (e) {
      print(e.response.toString());
      return Left(e.message.toString());
    }
  }

  Future<String> _updateWallet(double amount) async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.updateWallet + ConstantsManager.userId.toString(),
        data: {
          "amount": amount,
        },
      );
      return response.data["message"];
    } on DioException catch (e) {
      return e.response.toString();
    }
  }

  Future<String> _updatePendingWallet(double amount) async {
    try {
      Response response = await DioHelper.postData(
        path:
            EndPoints.updatePendingWallet + ConstantsManager.userId.toString(),
        data: {
          "amount": amount,
        },
      );
      return response.data["message"];
    } on DioException catch (e) {
      return e.response.toString();
    }
  }
}
