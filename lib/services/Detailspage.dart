import 'package:dspuiproject/Model/TestInformation.dart';
import 'package:dspuiproject/constant/colors.dart';
import 'package:dspuiproject/helper/utils.dart';
import 'package:dspuiproject/services/BookingTest3.dart';
import 'package:dspuiproject/services/cart2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dbHelper/DbHelper.dart';
import '../provider/CartProvider.dart';

class DetailsPage extends StatefulWidget {

  final TestInformation testInfo;

  const DetailsPage({Key? key, required this.testInfo}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int _selectedIndex = 0; // Track the selected tab index

  @override
  void initState() {
    super.initState();

    // Print details to console when the widget initializes
    printDetails();
  }
  void printDetails() {
    // Accessing details from widget.testInfo and printing to console
    print('ID: ${widget.testInfo.id}');
    print('Test Name: ${widget.testInfo.tests}');
    print('Reporting: ${widget.testInfo.reporting}');
    print('Rates: ${widget.testInfo.rates}');
    print('S No.: ${widget.testInfo.sNo}');
    print('Sample Collection: ${widget.testInfo.sampleColl}');
    print('Pre-test Information: ${widget.testInfo.preTestInformation}');
    print('Stability Room: ${widget.testInfo.staiblilityRoom}');
    print('Method: ${widget.testInfo.method}');
    print('Specimen: ${widget.testInfo.specimen}');
    print('Stability Refrigerated: ${widget.testInfo.staiblilityRefrigerated}');
    print('Parameters Covered: ${widget.testInfo.parametersCovered}');
    print('Stability Frozen: ${widget.testInfo.staiblilityFrozen}');
    print('Report Delivery: ${widget.testInfo.reportDelivery}');
    // Add more details as needed
  }
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    bool isInCart = cartProvider.addIdValue.contains(widget.testInfo.id.toString());
    DbHelper? dbhelper = DbHelper();


    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.testInfo.tests ?? 'info not avilable'),
          backgroundColor: iconcolor, // Default background color
          bottom: TabBar(
            tabs: [
              Tab(text: 'Patient Information'),
              Tab(text: 'Doctor Information'),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index; // Update selected index on tab change
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            PatientInformationTab(testInfo: widget.testInfo),
            DoctorInformationTab(testInfo: widget.testInfo),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                // handle add to cart

                  setState(() {
                    if (isInCart) {
                      // Remove from cart
                      // dbhelper?.delete(widget.testInfo.id!).then((value) {
                      //   cartProvider.removeTotalPrice(widget.testInfo.rates!.toInt());
                      //   cartProvider.removeCounter();
                      //   cartProvider.updateAddIdValue(widget.testInfo.id.toString());
                      //
                      // }).onError((error, stackTrace) {
                      //
                      //   print("error occurred: ${error.toString()}");
                      // });
                      Utils().toastmessage("test already in cart  ",Colors.red);

                    } else {
                      // Add to cart
                      dbhelper?.insert(
                        TestCart(
                          id: widget.testInfo.id.toString(),
                          rates: widget.testInfo.rates,
                          sampleColl:widget.testInfo.sampleColl,
                          reporting: widget.testInfo.reportDelivery,
                          tests: widget.testInfo.tests,
                        ),
                      ).then((value) {
                        cartProvider.addTotalPrice(widget.testInfo.rates!);
                        cartProvider.addcounter();
                        cartProvider.updateAddIdValue(widget.testInfo.id.toString());
                        Utils().toastmessage("test added success in cart ",Colors.green);
                      }).onError((error, stackTrace) {
                        print("error occurred: ${error.toString()}");
                      });
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: iconcolor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: Colors.blue), // Border color
                  ),
                ),
                child: Text('add to cart', style: TextStyle(color: Colors.black)),

              ),
              Column(
                children: [
                  Text("price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text("₹ ${widget.testInfo.rates}", style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart2()));

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: iconcolor, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: Colors.blue), // Border color
                  ),
                ),
                child: Text('BOOK A TEST', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientInformationTab extends StatefulWidget {
  final TestInformation testInfo;

  const PatientInformationTab({Key? key, required this.testInfo}) : super(key: key);

  @override
  State<PatientInformationTab> createState() => _PatientInformationTabState();
}

class _PatientInformationTabState extends State<PatientInformationTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey, // Background color
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PackageDetails(testInfo: widget.testInfo),
            SizedBox(height: 16.0),
            InformationRow(title: 'Pre-test Information',  value: widget.testInfo.preTestInformation ?? 'Information not available',),
            InformationRow(title: 'Test Type',  value: widget.testInfo.tests ?? 'Information not available',),
            InformationRow(title: 'Report Delivery',  value: widget.testInfo.reportDelivery ?? 'Information not available',),
            InformationRow(title: 'Components',  value:'Information not available',),
          ],
        ),
      ),
    );
  }
}


class DoctorInformationTab extends StatefulWidget {

  final TestInformation testInfo;

  const DoctorInformationTab({Key? key, required this.testInfo}) : super(key: key);

  @override
  State<DoctorInformationTab> createState() => _DoctorInformationTabState();
}

class _DoctorInformationTabState extends State<DoctorInformationTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PackageDetails(testInfo: widget.testInfo),
          SizedBox(height: 16.0),
          InformationRow(title: 'Test Name', value:widget.testInfo.tests ?? 'Information not available',),
          InformationRow(title: 'Code', value: 'Information not avilable'),
          InformationRow(title: 'Report Delivery', value: widget.testInfo.reportDelivery ?? 'Information not available',),
          InformationRow(title: 'Category', value: widget.testInfo.tests ?? 'Information not available',),
          InformationRow(title: 'Specimen', value: widget.testInfo.specimen ?? 'Information not available',),
          InformationRow(title: 'Stability Room', value: widget.testInfo.staiblilityRoom ?? 'Information not available',),
          InformationRow(title: 'Stability Refrigerated', value: widget.testInfo.staiblilityRefrigerated ?? 'Information not available',),
          InformationRow(title: 'Stability Frozen', value: widget.testInfo.staiblilityFrozen ?? 'Information not available',),
          InformationRow(title: 'method', value: widget.testInfo.method ?? 'Information not available',),
        ],
      ),
    );
  }
}


class PackageDetails extends StatefulWidget {
  final TestInformation testInfo;

  const PackageDetails({Key? key, required this.testInfo}) : super(key: key);

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTile(
              title: Text(
                'Package Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title:  Text(widget.testInfo.tests ?? 'package not found'),

                  onTap: () {
                    // Handle onTap event if needed
                  },
                ),
                // Add more ListTiles for additional options if needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InformationRow extends StatelessWidget {
  final String title;
  final String value;

  InformationRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      margin: EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: _getTabBackgroundColor(context), // Dynamic background color based on selected tab
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'Information not available',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to determine background color based on selected tab
  Color _getTabBackgroundColor(BuildContext context) {
    if (context.findAncestorWidgetOfExactType<TabBar>()?.controller?.index == 0) {
      return deeporange; // Background color for 'Patient Information' tab
    } else {
      return deeporange; // Background color for 'Doctor Information' tab
    }
  }
}
