import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:vendors/AppColor.dart';
import 'package:vendors/Models/CreditCardModel.dart';
import 'package:vendors/Models/ShippingAddressModel.dart';

import '../Data.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _activeStep = 0;
  List<GlobalKey<FormState>> formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
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
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,),onPressed: () => Navigator.pop(context)),
        title: const Text("Checkout Process",style: TextStyle(color: Colors.black,fontSize: 14),),
      ),
      body:  Padding(
                padding: const EdgeInsets.fromLTRB(AppColor.HorizontalPadding, 0, AppColor.HorizontalPadding,30),
                  child: Column(
                            children: [
                         IconStepper(
                                  activeStepBorderColor: AppColor.PrimaryColor.withOpacity(0.25),
                                  activeStepBorderWidth: 5,
                                  activeStepColor: AppColor.PrimaryColor,
                                  icons: [
                                    Icon(Icons.location_on,color: Colors.white),
                                    Icon(Icons.credit_card,color: Colors.white),
                                    Icon(Icons.list,color: Colors.white)
                                  ],
                                  steppingEnabled: false,
                                  enableNextPreviousButtons: false,
                                  scrollingDisabled: true,
                                  // activeStep property set to activeStep variable defined above.
                                  activeStep: _activeStep,
                                  // This ensures step-tapping updates the activeStep.
                                  onStepReached: (index) {
                                    setState(() {
                                      if(formKeys[_activeStep].currentState.validate()) {
                                        if (_activeStep < formKeys.length - 1) {
                                          _activeStep = _activeStep + 1;
                                        } else {
                                          _activeStep = 0;
                                        }
                                      }
                                    });
                                  },
                                ),

                              Expanded(child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: _activeStep  == 0 ? addressStep() : _activeStep == 1 ? cardStep() : addressStep(),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  if(_activeStep != 0)previousButton(),
                                  Expanded(child: Padding(
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
                    onSaved: (String value) {
                       addressModel.firstName = value;
                    },
                    maxLines: 1,
                    //initialValue: 'Aseem Wangoo',
                    validator: (value) {
                      if (value.isEmpty || value.length < 1) {
                        return 'Please enter valid name';
                      }
                    },
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
                        labelText: ' First Name',
                        //filled: true,
                        icon: const Icon(Icons.person),
                        labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
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
                        onSaved: (String value) {
                          addressModel.lastName = value;
                        },
                        maxLines: 1,

                        validator: (value) {
                          if (value.isEmpty || value.length < 1) {
                            return 'Please enter valid name';
                          }
                        },
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
                            labelText: 'Last Name',
                            //filled: true,
                          //  icon: const Icon(Icons.person),
                            labelStyle:
                            TextStyle(decorationStyle: TextDecorationStyle.solid)),
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
              onSaved: (String value) {
                addressModel.street = value;
              },
              maxLines: 1,
              //initialValue: 'Aseem Wangoo',
              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter valid address';
                }
              },
              decoration:  InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
              onSaved: (String value) {
                addressModel.postCode = value;
              },
              maxLines: 1,

              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please a valid post code';
                }
              },
              decoration:  InputDecoration(
                  labelText: 'Post Code',
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
              onSaved: (String value) {
                addressModel.country = value;
              },
              maxLines: 1,
              //initialValue: 'Aseem Wangoo',
              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please a valid country';
                }
              },
              decoration:  InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
                    onSaved: (String value) {
                      cardModel.cardName = value;
                    },
                    maxLines: 1,
                     maxLength: 16,

                    validator: (value) {
                      if (value.isEmpty || value.length < 1) {
                        return 'Please enter valid name';
                      }
                    },
                    decoration:  InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
              onSaved: (String value) {
                cardModel.cardNumber = value;
              },
              maxLines: 1,
              maxLength: 16,
              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter valid address';
                }
              },
              decoration:  InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
                    onSaved: (String value) {
                      cardModel.expireMonth = value;
                    },
                    maxLines: 1,
                    maxLength: 2,
                    validator: (value) {
                      if (value.isEmpty || value.length < 1) {
                        return 'invalid month';
                      }
                    },
                    decoration:  InputDecoration(
                        labelText: 'Expire Month',
                        border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
                        //filled: true,
                        icon: const Icon(Icons.date_range),
                        labelStyle:
                        TextStyle(decorationStyle: TextDecorationStyle.solid)),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autocorrect: false,
                      onSaved: (String value) {
                        cardModel.expireMonth = value;
                      },
                      maxLines: 1,
                      maxLength: 3,
                      validator: (value) {
                        if (value.isEmpty || value.length < 1) {
                          return 'invalid year';
                        }
                      },
                      decoration:  InputDecoration(
                          labelText: 'Expire Year',
                          border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
                          //filled: true,
                          labelStyle:
                          TextStyle(decorationStyle: TextDecorationStyle.solid)),
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
              onSaved: (String value) {
                addressModel.country = value;
              },
              maxLines: 1,
              maxLength: 4,
              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please a valid country';
                }
              },
              decoration:  InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: AppColor.PrimaryColor)),
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
  /// Returns the next button.
  Widget nextButton() {
    return Container(
     
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: AppColor.PrimaryColor,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (_activeStep < formKeys.length) {
          if(formKeys[_activeStep].currentState.validate()) {

              formKeys[_activeStep].currentState.save();
              print(addressModel.firstName);
              setState(() {
                _activeStep = _activeStep + 1;
              });
            }
          }else {
            print("Entereeeed");
            _payment();
          }
        },
        child: Text('Next'),
      ),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return Container(
      height: 60,
      width: 80,
      decoration: BoxDecoration(border: Border.all(color: AppColor.PrimaryColor,width: 1),borderRadius: BorderRadius.circular(10)),
      child: FlatButton(
        onPressed: () {

          if (_activeStep > 0) {
            setState(() {
              _activeStep--;
            });
          }
        },
        child: Icon(Icons.arrow_back,color: AppColor.PrimaryColor,),
        padding: const EdgeInsets.all(0),
      ),
    );
  }

  void _payment() async {
    var sendMap = <String, dynamic> {
      "firstName" : addressModel.firstName,
      "lastName" : addressModel.lastName,
      "street" : addressModel.street,
      "postCode" : addressModel.postCode,
      "country" : addressModel.country,
      "city" : "cairo",
      "cardNumber" : cardModel.cardNumber,
      "cardName" : cardModel.cardName,
      "expireMonth" : cardModel.expireMonth,
      "expireYear" : cardModel.expireYear,
      "CVV" : cardModel.CVV
    };
    var value;
    try {
      value = await Data.PLATFORM.invokeMethod("payment",sendMap);
    } catch (e) {
      print(e.toString());
    }
    print(value);
  }
}
