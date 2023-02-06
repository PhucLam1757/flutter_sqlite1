import "package:flutter/material.dart";
import 'package:flutter_sqlite1/models/model.dart';

class InsertScreen extends StatefulWidget {
  static const routeName = "insert_screen";
  // final Student? item;
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _initValues = {
    'name': '',
    'age': '',
    'phone': '',
  };
  // @override
  // void initState() {
  //   if (widget.item != null) {
  //     initValues(widget.item);
  //   }
  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)!.settings.arguments as Student?;
    if (args != null) {
      initValues(args);
    }
    super.didChangeDependencies();
  }

  void initValues(Student? item) {
    _initValues['name'] = item?.name;
    _initValues['age'] = item?.age.toString();
    _initValues['phone'] = item?.phone.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Thêm sinh viên", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.amberAccent,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              TextFormField(
                initialValue: _initValues['name'],
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _initValues['name'] = value ?? '';
                },
              ),
              TextFormField(
                  initialValue: _initValues['age'],
                  decoration: const InputDecoration(
                    labelText: 'Age',
                  ),
                  validator: (value) {
                    if (value?.isEmpty == true) {
                      return 'Please enter a age';
                    }
                    if (int.tryParse(value!) == null) {
                      return 'Please enter a valid number';
                    }
                    if (int.parse(value) <= 0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _initValues['age'] = value ?? '';
                  }),
              TextFormField(
                initialValue: _initValues['phone'],
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
                validator: (value) {
                  (value?.isEmpty == true) ? 'Please enter a phone' : null;
                  if (int.parse(value!) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  if (int.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _initValues['phone'] = value ?? '';
                },
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await _saveForm();
                  },
                  child: Text("Lưu"))
            ]),
          ),
        ),
      )),
    );
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();
      Navigator.pop(
          context,
          Student(
              // id: int.parse(_initValues["id"]),
              name: _initValues['name'],
              age: int.parse(_initValues['age']),
              phone: int.parse(
                _initValues['phone'],
              )));
    }
  }
}
