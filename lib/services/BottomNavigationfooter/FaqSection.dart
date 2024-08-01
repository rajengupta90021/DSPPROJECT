import 'package:dspuiproject/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_custom_selector/flutter_custom_selector.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iconcolor,
        title: Padding(
          padding: const EdgeInsets.only(right: 60.0),
          child: Center(child: Text("FAQS")),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: 100,
                width: 410,
        
                decoration: BoxDecoration(
                  color:greycolor,
                  // border: Border.all(
                  //   color: Colors.red, // Change color here
                  // ),
        
                ),
                child: Center(child: Text('Wallet Frequently Asked Questions' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
              ),
              Container(
                height: 465,
                width: 410,
                decoration: BoxDecoration(
                  // color:greycolor,
                  // border: Border.all(
                  //   // color: Colors.red, // Change color here
                  // ),
        
                ),
                child: ListView(
                  children: [
                    FAQItem(
                      question: "What is Swasth point?",
                      answer: "points accumulated in the consumer wallet of DSP LAb are called SWasth point .1 SWasth point = re 1.",
                    ),
                    FAQItem(
                      question: "how do I earn Swasth Point?",
                      answer: "wallet point can be earned in 2  ways \n  1. swasth point can be added in your wallet to be redemmed on particular test or within a particluar time limit \n \n 2.swasth point can be earned by appliying coupon code during booking a test either at the centre or on wesite/app coupon code will be send via sms/whataspp from DSP Lab ",
                    ),
                    FAQItem(
                      question: "How can I redeem swasth point ?",
                      answer: "once you have succesfully earned some swasth point you can walk int oour nearest lab or place an order on our website/app your maximum possible swasth point shall be automatically redeemd from your account",
                    ),
                    FAQItem(
                      question: "can Swasth point be encashed?",
                      answer: "SWasth point cannot be encashed .also you wouldn't to able to transfer it to the bank or any other wallet.",
                    ),
                    FAQItem(
                      question: "can I transfer my SWasth point?",
                      answer: " No ,Swasth point cannot be transfereed to any other LPL consumer ",
                    ),
                    FAQItem(
                      question: "How do  I add money into DSP wallet?",
                      answer: " Unfortunately you'd be unable  to directly add money to DSP wallet ,HOwerEver you can  accumulate Swasth Point through promotional offers",
                    ),
                    FAQItem(
                      question: "Can i lose my earned Swasth Points?",
                      answer: " Swasth point earned on any order shall remain valid for a period  of 180 days from ythe date when such points are credited to your DSP wallet",
                    ),
                    FAQItem(
                      question: "Can i Club Swasth point with other Promotional offers ?",
                      answer: " No, swasth point cannot be clubbed with any other promotional or other discount offers",
                    ),
                    FAQItem(
                      question: "How much Swasth point can i redeem per order?",
                      answer: " For Senior citizens,100% of swasth point can be redeemed per order",
                    ),
        
                  ],
                ),
        
              ),

              SizedBox(height: 5,),
              Container(
                height: 70,
                width: 500,
                child: GestureDetector(
                  onTap: () {
                    // Implement action when the text is clicked
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Please refer to our ",
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: TextStyle(
                              color: Colors.blue, // Change color as needed
                              decoration: TextDecoration.underline, // Underline style
                            ),
                          ),
                          TextSpan(
                            text: " for more details",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ),
              SizedBox(height: 15,),



            ],
        
            // Your FAQ content here
          ),
        ),
      ),
    );
  }
  }



class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(widget.answer),
        ),
      ],
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      initiallyExpanded: _isExpanded,
    );
  }
}

