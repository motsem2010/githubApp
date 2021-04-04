import 'package:flutter/material.dart';
import 'package:github_app/controller/api_services.dart';
import 'package:github_app/model/gethub_repo_obj.dart';
import 'package:github_app/view/repo_list.dart';

Widget login_info_form(context, TextEditingController tc1,
    TextEditingController tc2, String hint1, String hint2, Function f1) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: TextField(
            controller: tc1,
            decoration: InputDecoration(
//                labelText: 'Enter User Name',
                hintText: hint1,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)))),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: TextField(
            obscuringCharacter: '#',
            obscureText: true,
            controller: tc2,
            decoration: InputDecoration(
                prefixIcon: IconButton(
                    icon: Icon(Icons.security),
                    onPressed: () {
                      tc2.text = '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';
                    }),
//                labelText: 'Enter User Name',
                hintText: hint2,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)))),
      ),
//      MaterialButton(onPressed: f2,
//      shape:  StadiumBorder(),
//        color: Colors.white,
//          textColor: Colors.blue,
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
//            child: Text('Continue..'),
//          ),
//      ),
      MaterialButton(
        onPressed: f1,
        shape: StadiumBorder(),
        color: Colors.white,
        textColor: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Text('Continue..'),
        ),
      ),

//      MaterialButton(onPressed: ()async{
//
//      },
//        shape:  StadiumBorder(),
//        color: Colors.white,
//        textColor: Colors.blue,
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
//          child: Text('Go to RepoList'),
//        ),
//
//      ),
    ],
  );
}

Widget login_button_col(context, Function f) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Center(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: MaterialButton(
          onPressed: f,
          child: Text(
            'Sign In with GitHub',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 2,
//                          fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.headline6.fontSize),
          ),
        ),
      )),
      RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.white),
          children: <TextSpan>[
            TextSpan(text: ' By signing in you accept our '),
            TextSpan(
                text: 'Term of ose',
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold)),
            TextSpan(text: ' and '),
            TextSpan(
                text: 'Privicy policies',
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold)),
          ],
        ),
      )
    ],
  );
}
