import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/CartModel.dart';
import 'package:vendors/Models/CreditCardModel.dart';
import 'package:vendors/Models/GateModel.dart';
import 'package:vendors/Models/ShippingAddressModel.dart';

import '../Data.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _activeStep = 0;
  bool isLoadingPayment = false;
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  ShippingAddressModel addressModel = ShippingAddressModel();
  CreditCardModel cardModel = CreditCardModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: const Text(
          "Checkout Process",
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
            AppColor.HorizontalPadding, 0, AppColor.HorizontalPadding, 30),
        child: Column(
          children: [
            IconStepper(
              activeStepBorderColor: AppColor.PrimaryColor.withOpacity(0.25),
              activeStepBorderWidth: 5,
              activeStepColor: AppColor.PrimaryColor,
              icons: [
                Icon(Icons.location_on, color: Colors.white),
                Icon(Icons.credit_card, color: Colors.white),
                Icon(Icons.list, color: Colors.white)
              ],
              steppingEnabled: false,
              enableNextPreviousButtons: false,
              scrollingDisabled: true,
              // activeStep property set to activeStep variable defined above.
              activeStep: _activeStep,
              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  if (formKeys[_activeStep].currentState!.validate()) {
                    if (_activeStep < formKeys.length - 1) {
                      _activeStep = _activeStep + 1;
                    } else {
                      _activeStep = 0;
                    }
                  }
                });
              },
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: _activeStep == 0
                  ? addressStep()
                  : _activeStep == 1
                      ? cardStep()
                      : isLoadingPayment ? Center(child: CircularProgressIndicator()) : summaryStep(),
            )),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (_activeStep != 0) previousButton(),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: nextButton(),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addressStep() {
    return Form(
      key: formKeys[0],
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    onSaved: (value)  {
                      addressModel.firstName = value!;
                    },
                    maxLines: 1,
                    // ignore: missing_return
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 1) {
                        return 'Please enter valid name';
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.PrimaryColor)),
                        labelText: ' First Name',
                        //filled: true,
                        icon: const Icon(Icons.person),
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      onSaved: (value) {
                        addressModel.lastName = value!;
                      },
                      maxLines: 1,
                      // ignore: missing_return
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 1) {
                          return 'Please enter valid name';
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.PrimaryColor)),
                          labelText: 'Last Name',
                          //filled: true,
                          //  icon: const Icon(Icons.person),
                          labelStyle: TextStyle(
                              decorationStyle: TextDecorationStyle.solid)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              onSaved: ( value) {
                addressModel.street = value ?? "";
              },
              maxLines: 1,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please enter valid address';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  labelText: 'Address',
                  //filled: true,
                  icon: const Icon(Icons.location_on),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              autocorrect: false,
              onSaved: ( value) {
                addressModel.postCode = value ?? "";
              },
              maxLines: 1,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please a valid post code';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Post Code',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  //filled: true,
                  icon: const Icon(Icons.insert_drive_file),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.streetAddress,
              autocorrect: false,
              onSaved: ( value) {
                addressModel.country = value ?? "";
              },
              maxLines: 1,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please a valid country';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  labelText: 'Country',
                  //filled: true,
                  icon: const Icon(Icons.location_city),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardStep() {
    return Form(
      key: formKeys[1],
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              autocorrect: false,
              onSaved: ( value) {
                cardModel.cardName = value ?? "";
              },
              maxLines: 1,
              maxLength: 16,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please enter valid name';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  labelText: 'Card Name',
                  //filled: true,
                  icon: const Icon(Icons.person),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              autocorrect: false,
              onSaved: (value) {
                cardModel.cardNumber = value ?? "";
              },
              maxLines: 1,
              maxLength: 16,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please enter valid address';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  labelText: 'Card Number',
                  //filled: true,
                  icon: const Icon(Icons.credit_card),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    onSaved: ( value) {
                      cardModel.expireMonth = value ?? "";
                    },
                    maxLines: 1,
                    maxLength: 2,
                    // ignore: missing_return
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 1) {
                        return 'invalid month';
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Expire Month',
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.PrimaryColor)),
                        //filled: true,
                        icon: const Icon(Icons.date_range),
                        labelStyle: TextStyle(
                            decorationStyle: TextDecorationStyle.solid)),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      onSaved: ( value) {
                        cardModel.expireYear = value ?? "";
                      },
                      maxLines: 1,
                      maxLength: 3,
                      // ignore: missing_return
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 1) {
                          return 'invalid year';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Expire Year',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColor.PrimaryColor)),
                          //filled: true,
                          labelStyle: TextStyle(
                              decorationStyle: TextDecorationStyle.solid)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              autocorrect: false,
              onSaved: ( value) {
                cardModel.CVV = value!;
              },
              maxLines: 1,
              maxLength: 4,
              // ignore: missing_return
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1) {
                  return 'Please a valid country';
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.PrimaryColor)),
                  labelText: 'CVV',
                  //filled: true,
                  icon: const Icon(Icons.privacy_tip),
                  labelStyle:
                      TextStyle(decorationStyle: TextDecorationStyle.solid)),
            ),
          ),
        ],
      ),
    );
  }

  Widget summaryStep() {
    return   Consumer<Cart>(
      builder: (context, value, child) =>SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 75,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: AppColor.PrimaryColor.withOpacity(0.10),),
                child: Align(
                  alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColor.PrimaryColor),
                      ),
                    ),
                  ),
                ),
               Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text("Products",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${value.getCartModel[index].count}X ${value.cartModel[index].product.productNameEn}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                            subtitle: Text("${value.cartModel[index].product.productPrice} L.E",style: TextStyle(color: AppColor.PrimaryColor,fontWeight: FontWeight.w600,fontSize: 14)),);
                          },
                          itemCount: value.getCartModel.length,
                        ),

                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14)),
                          Text("${value.getCartModel.isNotEmpty ? value.getCartModel.map((e) => e.count * e.product.productPrice).reduce((value, element) => value + element) : "0"}",style: TextStyle(color: AppColor.PrimaryColor,fontWeight: FontWeight.bold,fontSize: 20))
                        ],
                      ),
                    ),
                    Divider(),
                    const Text("Your Data",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                    ListTile(leading: Icon(Icons.location_on,color: AppColor.SecondColor),title: const Text("Address",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 12)),subtitle: Text("${addressModel.street},${addressModel.country},${addressModel.city}",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600,fontSize: 13)),),
                    ListTile(leading: Icon(Icons.credit_card,color: AppColor.SecondColor),title: const Text("Name",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 12)),subtitle: Text("${cardModel.cardName}",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600,fontSize: 13)),),
                    ListTile(leading: SizedBox(),title: const Text("Number",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 12)),subtitle: Text("${cardModel.cardNumber}",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600,fontSize: 13))),
                    ListTile(leading: SizedBox(),title: const Text("Exp Date",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 12)),subtitle: Text("${cardModel.expireMonth}/${cardModel.expireYear}",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600,fontSize: 13))),
                    ListTile(leading: SizedBox(),title: const Text("CVV",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600,fontSize: 12)),subtitle: Text("${cardModel.CVV}",style: TextStyle(color: AppColor.SecondColor,fontWeight: FontWeight.w600,fontSize: 13))),
                  ],
    ),
                ),
            
            ],
          ),
        ),
      ));

  }

  /// Returns the next button.
  Widget nextButton() {
    return Container(
      height: 60,
      child: Consumer<Cart>(
        builder: (context, value, child) => ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: _activeStep  != 2 ? AppColor.PrimaryColor : Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: !isLoadingPayment ? () {
            if (_activeStep < formKeys.length) {
              if (formKeys[_activeStep].currentState!.validate()) {
                formKeys[_activeStep].currentState!.save();
                print(addressModel.firstName);
                setState(() {
                  _activeStep = _activeStep + 1;
                });
              }
            } else {
              final temp = jsonEncode(value.cartModel
                  .map((e) => SendCart(e.product.productId, e.count).toJson())
                  .toList());
              setState(() {
                isLoadingPayment = true;
              });
              Data.payment(cart: temp).then((data) => _payment(data).then((data1) => data1 == "Success" ? Data.token(sessionId: data.sessionID,orderId: data.orderID).then((data2) {

                value.removeAllCart();
                return showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Icon(Icons.check,color: Colors.green,size: 50,),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );}) :    showDialog<void>(
                context: context,
                barrierDismissible: true, // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Failed'),
                    content: Icon(Icons.close,color: Colors.red,size: 50,),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK!'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )));
            }
          } : null,
          child: Text(_activeStep  != 2 ? "NEXT" : "DONE"),
        ),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.PrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: FlatButton(

        onPressed: !isLoadingPayment ? () {
          if (_activeStep > 0) {
            setState(() {
              _activeStep--;
            });
          }
        } : null,
        child: Icon(
          Icons.arrow_back,
          color: AppColor.PrimaryColor,
        ),
        padding: const EdgeInsets.all(0),
      ),
    );
  }

  Future<String> _payment(GateModel gateModel) async {
    var sendMap = <String, dynamic>{
      "firstName": addressModel.firstName,
      "lastName": addressModel.lastName,
      "street": addressModel.street,
      "postCode": addressModel.postCode,
      "country": addressModel.country,
      "city": "cairo",
      "cardNumber": cardModel.cardNumber,
      "cardName": cardModel.cardName,
      "expireMonth": cardModel.expireMonth,
      "expireYear": cardModel.expireYear,
      "CVV": cardModel.CVV,
      "merchantID": gateModel.merchantID,
      "sessionID": gateModel.sessionID,
      "api": gateModel.apiVersion
    };

    var value;
    try {
      value = await Data.PLATFORM.invokeMethod("payment", sendMap);
    } catch (e) {
      print(e.toString());
    }
   return value;
  }
}
