import 'package:copyongtoolkit/utils/PreferenceUtil.dart';
import 'package:copyongtoolkit/widgets/MainDrawer.dart';
import 'package:flutter/material.dart';

class DemoSharedPreference extends StatefulWidget {
  @override
  _DemoSharedPreferenceState createState() => _DemoSharedPreferenceState();
}

class _DemoSharedPreferenceState extends State<DemoSharedPreference> {
  final _formKey = GlobalKey<FormState>();
  String _username;

  Future<void> _init() async {
    _username = await PreferenceUtil.instance.getLastLoggedInUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Geo Location'),
      ),
//      body: formContent(),
      body: FutureBuilder(
        future: _init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return formContent();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget formContent() {
    return Form(
      key: _formKey,
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                initialValue: _username,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  _username = value;
                  return null;
                },
              ),
              Builder(
                builder: (context) => RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      PreferenceUtil.instance.setLastLoggedInUsername(_username);
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Saved into Shared Preference')));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
