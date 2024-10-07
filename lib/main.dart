import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_clickpay_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_clickpay_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_clickpay_bridge/PaymentSDKQueryConfiguration.dart';
import 'package:flutter_clickpay_bridge/PaymentSDKSavedCardInfo.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkApms.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkTokenFormat.dart';
import 'package:flutter_clickpay_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_clickpay_bridge/flutter_clickpay_bridge.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _instructions = 'Tap on "Pay" Button to try Clickpay plugin';

  @override
  void initState() {
    super.initState();
  }

  PaymentSdkConfigurationDetails generateConfig() {
    var billingDetails = BillingDetails("test test", "email@domain.com",
        "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    // var shippingDetails = ShippingDetails("John Smith", "email@domain.com",
    //     "+97311111111", "st. 12", "eg", "dubai", "dubai", "12345");
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.KNET_DEBIT);
    apms.add(PaymentSdkAPms.APPLE_PAY);
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "44537",
        serverKey: "SNJNLMJZB9-JHTGGRN6LM-H9NLGLJRNK",
        clientKey: "C7KMD2-7R6H6H-7TTRQG-MKTRQG",
        cartId: "1243",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        screentTitle: "Pay with Card",
        amount: 1.0,
        billingDetails: billingDetails,
        forceShippingInfo: false,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        alternativePaymentMethods: apms,
        tokeniseType: PaymentSdkTokeniseType.USER_OPTIONAL,
        tokenFormat: PaymentSdkTokenFormat.Hex32Format,
        linkBillingNameWithCardHolderName: true);

    var theme = IOSThemeConfigurations();
    theme.secondaryColor = "000000";
    theme.buttonColor = "000000";
    theme.inputsCornerRadius = 10;
    configuration.iOSThemeConfigurations = theme;
    return configuration;
  }

  Future<void> queryPressed() async {
    FlutterPaymentSdkBridge.queryTransaction(generateQueryConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payPressed() async {
    FlutterPaymentSdkBridge.startCardPayment(generateConfig(), (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWithTokenPressed() async {
    FlutterPaymentSdkBridge.startTokenizedCardPayment(
        generateConfig(), "*Token*", "*TransactionReference*", (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWith3ds() async {
    FlutterPaymentSdkBridge.start3DSecureTokenizedCardPayment(
        generateConfig(),
        PaymentSDKSavedCardInfo("4575 53## #### 5267", "visa"),
        "394154BC67A3E832C7BF94F4648679BA", (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> payWithSavedCards() async {
    FlutterPaymentSdkBridge.startPaymentWithSavedCards(generateConfig(), false,
        (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
            if (transactionDetails["isPending"]) {
              print("transaction pending");
            }
          } else {
            print("failed transaction");
          }

          // print(transactionDetails["isSuccess"]);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> apmsPayPressed() async {
    FlutterPaymentSdkBridge.startAlternativePaymentMethod(generateConfig(),
        (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "42781",
        serverKey: "SKJNLMJZJ2-J6HRNZNLW2-GKMJ2KJBM2",
        clientKey: "CQKMD2-7R276G-HRQ9QB-MMKMK6",
        cartId: "12433",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 2.0,
        currencyCode: "SAR",
        merchantCountryCode: "SA",
        merchantApplePayIndentifier: "merchant.clickpaysa.direct",
        isDigitalProduct: true,
        simplifyApplePayValidation: false);
    FlutterPaymentSdkBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          print(transactionDetails);
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  Widget applePayButton() {
    if (Platform.isIOS) {
      return TextButton(
        onPressed: () {
          applePayPressed();
        },
        child: Text('Pay with Apple Pay'),
      );
    }
    return SizedBox(height: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Clickpay Plugin Example App'),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Text('$_instructions'),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  payPressed();
                },
                child: Text(
                  'Pay with Card',
                  style: TextStyle(
                    color: _colorFromHex("#000000"),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  payWithTokenPressed();
                },
                child: Text('Pay with Token'),
              ),
              TextButton(
                onPressed: () {
                  payWith3ds();
                },
                child: Text('Pay with 3ds'),
              ),
              TextButton(
                onPressed: () {
                  payWithSavedCards();
                },
                child: Text('Pay with saved cards'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  apmsPayPressed();
                },
                child: Text('Pay with Alternative payment methods'),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  queryPressed();
                },
                child: Text('Query transaction'),
              ),
              SizedBox(height: 16),
              applePayButton()
            ])),
      ),
    );
  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  PaymentSDKQueryConfiguration generateQueryConfig() {
    return new PaymentSDKQueryConfiguration("SKJNLMJZJ2-J6HRNZNLW2-GKMJ2KJBM2",
        "CQKMD2-7R276G-HRQ9QB-MMKMK6", "SA", "42781", "TST2423100181581");
  }
}
