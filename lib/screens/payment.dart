import 'package:a_commerce/utilites/constants.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  final int amount;
  final String OrderId;
  final String email;

  Payment({this.amount,this.OrderId,this.email});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final Razorpay razorpay = Razorpay();

  @override
  void initState() {
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, paySuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, payError);
    super.initState();
  }

  void externalWallet(ExternalWalletResponse response){
    print(response.walletName);
  }

  void paySuccess(PaymentSuccessResponse response){
    print(response.paymentId.toString());
  }

  void payError(PaymentFailureResponse response){
    print(response.message + response.code.toString());
  }

  getPayment(){
    var option = {
      'key' : 'rzp_test_17GuvQhtkmtuSB',
      'amount' : widget.amount*100,
      'orderId' : widget.OrderId,
      'name' : 'Parth',
      'prefill' : {
        'contact' : '123456789',
        'email' : widget.email
      }
    };

    try{
      razorpay.open(option);
    }catch(e){
      print('erroris $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                '${widget.amount}',
              style: kheadstyle,
            ),
            RaisedButton(
                child: Text('Pay',style: kBoldheadstyle,),
                onPressed: (){
                  getPayment();
                }
            )
          ],
        ),
      ),
    );
  }
}
