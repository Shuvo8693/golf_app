/*
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:golf_game_play/app/data/api_constants.dart';
import 'package:golf_game_play/common/prefs_helper/prefs_helpers.dart';
import 'package:golf_game_play/sk_key.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController{

  Map<String, dynamic>? paymentIntent;
  RxMap<int,bool> isLoading= <int,bool>{}.obs;
  Future<void> makePayment(String amount,String currency,dynamic subscriptionId, String subscriberId,String subscriptionType,String planType,int index) async {

    try {
      isLoading[index]=true;
      // Create payment intent data
      paymentIntent = await createPaymentIntent(amount, currency);
      // initialise the payment sheet setup
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Client secret key from payment data
          paymentIntentClientSecret: paymentIntent?['client_secret']??'',
          // Merchant Name
          merchantDisplayName: 'GolfTournament',
          // return URl if you want to add
          // returnURL: 'flutterstripe://redirect',
        ),
      );
      print(paymentIntent);
      // Display payment sheet
     await displayPaymentSheet(subscriptionId,subscriberId, subscriptionType,planType);
    }on SocketException catch (_) {
      Get.snackbar(
        'Error',
        'No internet connection. Please check your network and try again.',
        snackPosition: SnackPosition.TOP,
      );
    } catch (error) {
      print("exception $error");

      if (error is StripeConfigException) {
        print("Stripe exception ${error.message}");
      } else {
        print("exception $error");
      }
    } finally {
      isLoading[index] = false;
    }
  }

  displayPaymentSheet(String subscriptionId, String subscriberId,String subscriptionType,String planType) async {
    try {
      // "Display payment sheet";
      await Stripe.instance.presentPaymentSheet();
      // Show when payment is done
         dynamic transactionId = paymentIntent?['id'];
         String? currency = paymentIntent?['currency'];
         int? amount =paymentIntent?['amount'] ;
         String? purchaseToken =paymentIntent?['client_secret'];
      print(paymentIntent.toString());
      print(subscriptionId.toString());
      if(transactionId !=null && amount !=null && purchaseToken !=null){
       await handlePayment(transactionId,subscriptionId,amount, paymentIntent??{},subscriberId ,subscriptionType,planType);
      }
      //Get.snackbar('Payment Successful', '');
       paymentIntent = null;
    } on StripeException catch (e) {
      print('Error: $e');
      Get.snackbar('Payment Abort', '');

    } catch (e) {
      print("Error in displaying");
      print('$e');
    }
  }
 /// Create payment Intend
  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      // Validate amount input
      if (amount.isEmpty || double.tryParse(amount) == null) {
        print('Invalid amount: $amount');
        Get.snackbar("Error", "Invalid amount format.");
        return null;
      }

      int amountInCents = (double.parse(amount) * 100).toInt();

      Map<String, dynamic> body = {
        'amount': amountInCents.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${SKey.sSecTestKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
        var decodedBody= jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('Payment Intent created: ${response.body}');
        return  decodedBody;
      } else {
        print('Failed to create Payment Intent: ${response.body}');
        Get.snackbar("Error", "Failed to create payment intent.");
        return null;
      }
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      Get.snackbar("Error", "Payment Intent creation error.");
      return null;
    }
  }


   handlePayment(dynamic transactionId, String subscriptionId,int amountInCent,Map<String,dynamic> stripeResponseData,String subscriberId, String subscriptionType,String planType) async {
    String userToken = await PrefsHelper.getString('token');
   print('Stripe response data===========: $stripeResponseData');
   double amount = (amountInCent/100).toDouble();
    Map<String,dynamic> body = {
      "subscriptionType":subscriptionType,
      "stripeSubscriptionId":subscriptionId,
      "stripeCustomerId":subscriberId,
      "planPrice":amount,
      "paymentMethod":"credit_card",
      "planType":planType
    };
    Map<String,String> header={
      'Content-Type':'application/json',
      'Authorization': 'Bearer $userToken'
    };
   var request = await http.post(Uri.parse(ApiConstants.paymentSubscriptionUrl),body: jsonEncode(body),headers:header );

   var responseBody = jsonDecode(request.body);
    if (request.statusCode == 201) {
      print("Payment response: $responseBody");
      Get.dialog(
        barrierDismissible: true,
        AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your payment has been processed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
               Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      Get.snackbar('Failed payment record ', responseBody['message'].toString(),);
    }
  }
}*/
