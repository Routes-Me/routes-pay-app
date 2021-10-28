import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
class MyFatoorah{

  Future initiate(BuildContext context,double amount,int paymentMethodId)async{
    MFSDK.init('https://apitest.myfatoorah.com/', 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL');
    var request = new MFInitiatePaymentRequest(amount, MFCurrencyISO.KUWAIT_KWD);

    MFSDK.initiatePayment(request, MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {

          if(result.isSuccess()) {
            print(result.response!.toJson().toString())
          }
          else {
            print(result.error!.message)
          }
        });
    setAppBar();
    executePayment(context,amount,paymentMethodId);
    return request;
  }

  //Execute Payment
  Future executePayment(BuildContext context,double amount,int paymentMethodId)async{
    int paymentMethod = paymentMethodId;

    var request = new MFExecutePaymentRequest(paymentMethod, amount,);

    MFSDK.executePayment(context, request, MFAPILanguage.EN,
            (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {

          if(result.isSuccess()) {
            print(result.response!.toJson().toString())
          }
          else {
            print(result.error!.message)
          }
        });
    return request;
  }

  //Direct Payment / Tokenization
  Future directPayment(BuildContext context)async{
    MFCardInfo(cardToken: "put your token here");
    // The value 2 is the paymentMethodId of Visa/Master payment method.
// You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
    int paymentMethod = 2;

    var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

// var mfCardInfo = new MFCardInfo(cardToken: "Put your token here");

    var mfCardInfo = new MFCardInfo(cardToken: '2ewwwd',cardNumber: "4508750015741019", expiryMonth:"05",expiryYear: "22",securityCode: "100",
        bypass3DS: false, saveToken: false);

    MFSDK.executeDirectPayment(context, request, mfCardInfo, MFAPILanguage.EN,
            (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {

          if(result.isSuccess()) {
            print(result.response!.toJson().toString())
          }
          else {
            print(result.error!.message)
          }
        });
    return request;
  }

  //Payment Enquiry
  Future paymentEnquiry(BuildContext context)async{
    var request = MFPaymentStatusRequest(invoiceId: "1099724",paymentId: '0706109972487861669');

    MFSDK.getPaymentStatus(MFAPILanguage.EN, request,
            (MFResult<MFPaymentStatusResponse> result) => {

          if(result.isSuccess()) {
            print(result.response!.toJson().toString())
          }
          else {
            print(result.error!.message)
          }
        });
    return request;
  }

  //set app bar
  void setAppBar(){
  MFSDK.setUpAppBar(
      title: "MyFatoorah Payment",
      titleColor: Colors.white,  // Color(0xFFFFFFFF)
      backgroundColor: Colors.blue.shade800, // Color(0xFF000000)
      isShowAppBar: true); // For Android platform o
}

}