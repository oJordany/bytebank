import 'package:bytebank/components/custom_switch_widget.dart';
import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

const _appBarTitle = 'New Contact';

class ContactFormPage extends StatefulWidget {
  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full name',
                ),
                style: TextStyle(
                  fontSize: 32.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: 'Account number',
                  ),
                  style: TextStyle(
                    fontSize: 32.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      final String name = _nameController.text;
                      final int accountNumber =
                          int.tryParse(_accountNumberController.text)!;
                      final Contact newContact = Contact(
                        id: 0,
                        name: name,
                        accountNumber: accountNumber,
                      );
                      _contactDao.save(newContact).then((id) => 
                        Navigator.pop(context, newContact)
                      );
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
