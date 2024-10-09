import 'package:care_life/controller/user_provider.dart';
import 'package:care_life/view/components/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final String home;

  const PaymentScreen({super.key, required this.home});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameOnCardController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter amount";
                }
                return null;
              },
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'amount',
                hintText: 'enter your amount',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLength: 19,
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter cart number";
                }
                return null;
              },
              onChanged: (value) {
                if (value.length == 4) {
                  _cardNumberController.text += '/';
                } else if (value.length == 9) {
                  _cardNumberController.text += '/';
                } else if (value.length == 14) {
                  _cardNumberController.text += '/';
                }
              },
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      required maxLength}) =>
                  null,
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: '1234/1234/1234/1234',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    maxLength: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter expiry date";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.length == 2) {
                        _expiryDateController.text += "/";
                      }
                    },
                    buildCounter: (context,
                            {required currentLength,
                            required isFocused,
                            required maxLength}) =>
                        null,
                    controller: _expiryDateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date (MM/YY)*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length != 3) {
                        return "enter valid CVV";
                      }
                      return null;
                    },
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CVV*',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "enter name";
                }
                return null;
              },
              controller: _nameOnCardController,
              decoration: const InputDecoration(
                labelText: 'Name on Card*',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
              child: 'Pay Now',
              onTap: () {
                if (formKey.currentState!.validate()) {
                  context
                      .read<UserProvider>()
                      .sendDonations(_amountController.text, widget.home)
                      .then((value) => Get.back());
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
