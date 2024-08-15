import 'package:bytebank/components/contact/item_widget.dart';
import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact/form_page.dart';
import 'package:bytebank/screens/transaction/form_page.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'Transfer';

class ContactListPage extends StatefulWidget {
  ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  final List<Contact> contacts = [];
  final ContactDao _contactDao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          CustomSwitch(),
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _contactDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact>? contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts![index];
                  return ContactItem(
                    contact: contact,
                    onClick: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TransactionForm(contact)),
                      );
                    },
                  );
                },
                itemCount: contacts?.length,
              );
          }
          ;
          return Text('Unknown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => ContactFormPage(),
            ),
          )
              .then(
            (newContact) {
              if (newContact != null) {
                setState(() {});
              }
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
