import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/screens/contact/list_page.dart';
import 'package:bytebank/components/dashboard/feature_item.dart';
import 'package:bytebank/screens/transaction/list_page.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Dashboard';
const _contactsContainerTitle = 'Transfer';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset('assets/images/bytebank_logo.png'),
            ),
          ),
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FeatureItem(
                  name: 'Transfer',
                  icon: Icons.monetization_on,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                FeatureItem(
                  name: 'Transaction Feed',
                  icon: Icons.description,
                  onClick: (){
                    _showTransactionList(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showContactsList(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactListPage(),
      )
    );
  }

  void _showTransactionList(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsListPage(),
      )
    );
  }
}
