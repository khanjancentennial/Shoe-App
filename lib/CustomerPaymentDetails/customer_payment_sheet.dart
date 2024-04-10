import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';


class StripePaymentHandle {
  double? total;


  StripePaymentHandle({this.total});
  Map<String, dynamic>? paymentIntent;


}