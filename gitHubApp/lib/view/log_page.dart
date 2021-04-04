import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/controller/api_services.dart';
import 'package:github_app/controller/state_controller.dart';
import 'package:github_app/model/gethub_repo_obj.dart';
import 'package:github_app/view/repo_list.dart';
import 'package:github_app/view/wdgts/login_button_col.dart';

class LoginPage extends StatelessWidget {
  TextEditingController tc1 = new TextEditingController();
  TextEditingController tc2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _contr = Get.put(StatControl());
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: CircleAvatar(
                        minRadius: 50,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.black,
                        ))),
//            Obx((){
//              return Text('${_contr.isLogged}');
//            }),
                Obx(() {
                  return Visibility(
                    visible: _contr.isLoading.value,
                    child: CircularProgressIndicator(),
                  );
                }),
                Obx(() {
                  if (_contr.isLogged == 1.obs) {
                    return Text('welcome ${_contr.user_name}');
                  } else {
                    return Text('no  user');
                  }
                }),
              ],
            ),
            Obx(() {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 1200),
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.bounceOut,
                child: _contr.isLogged == 1.obs
                    ? login_info_form(
                        context, tc1, tc2, 'GitHub User', 'Token',
                        () async {
                        String usern = tc1.text.trim();
                        String tokenid = tc2.text.trim();
//       String user_mot='motsem2010';
//       String token_mot='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';

                        if (usern.length > 0 &&
                            tokenid.length > 0 &&
                            usern.isNotEmpty) {
                          _contr.isLoading.value = true;
                          _contr.statusStr.value='Authenticate';
                          String x =
                              await ApiServices.auth_service(usern, tokenid);
                          print('respone from auth=$x');
                          if (x.toString().toLowerCase() == 'ok') {

                            _contr.user_name.value=usern;
                            _contr.token.value=tokenid;
                            //pass to repo List
                            //'iharshb' test user
                            _contr.statusStr.value='get Repos...';
                            List<GitHubRepo> x =
                                await ApiServices.obtainJson(usern);
                            _contr.isLoading.value = false;
                            if (x.length > 0 && x.isNotEmpty) {
                              _contr.repo.value = x;
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return RepoList();
                                  }));
                            } else _contr.statusStr.value='No Repos.';
                          }else _contr.statusStr.value='bad Auth';
                        }
                        _contr.isLoading.value = false;
                      })
                    : login_button_col(context, () {
                        if (tc1.text.trim().length > 2 &&
                            tc2.text.trim().length > 2) {}
                        _contr.updateVar();
                        print('we do change');
                      }),
              );
            }),
            Obx(
                (){
                  return
                  Text(_contr.statusStr.value,style: TextStyle(color: Colors.redAccent,fontSize: 10.0),);
                      ;
                }
            )
          ],
        ),
      ),
    );
  }
}
