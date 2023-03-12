
import 'package:flutter/material.dart';


class Contact {
  final String name;
  final String phoneNumber;

  Contact({required this.name, required this.phoneNumber});
}

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  List<Contact> contacts = [
    Contact(name: "Adul", phoneNumber: "0876565559"),
    Contact(name: "Udin", phoneNumber: "0865544555"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: const Text("Contacts"),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = contacts[index];
          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phoneNumber),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateContactPage()),
          );
          if (result != null) {
            setState(() {
              contacts.add(result);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Kontak Berhasil di tambahkan'),
                  
                ),
              );
            });
          }
        },
         child: const Icon(
    Icons.add,
    color: Colors.black,
    size: 30,
  ),
       
      ),
    );
  }
}



class CreateContactPage extends StatefulWidget {
  const CreateContactPage({Key? key}) : super(key: key);

  @override
  CreateContactPageState createState() => CreateContactPageState();
}

class CreateContactPageState extends State<CreateContactPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Contact"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tolong Masukan Nomor Anda";
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nomor Handphone"),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tolong Masukan Nomor HandPhone Anda";
                  }
                  return null;
                },
                onSaved: (value) {
                  _phoneNumber = value!;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Contact contact =
                        Contact(name: _name, phoneNumber: _phoneNumber);
                    Navigator.pop(context, contact);
                  }
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}