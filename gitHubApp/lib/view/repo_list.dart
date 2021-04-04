import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_app/controller/state_controller.dart';
import 'package:github_app/model/gethub_repo_obj.dart';

class RepoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final StatControl _cont2 = Get.find();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(),
        body: Obx(() {
          return Column(
            children: [
              Text('Repositories',style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.white),textAlign: TextAlign.start,),
              Expanded(
                child: FutureBuilder(
                    future: _cont2.getRepoList(),
                    builder: (context, snapshpt) {
                      List<GitHubRepo> objs = snapshpt.data;
                      if(snapshpt.hasData)
                        {
                          return ListView.builder(
                            itemCount: _cont2.repo.value.length,
                            itemBuilder: (cotext, ind) {
                              return ListTile(
                                title: Text(_cont2.repo.value[ind].name),
                                subtitle: Text(_cont2.repo.value[ind].fullName),
                                leading: Icon(Icons.shopping_bag),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: (){
                                  showModelV(context,_cont2.repo.value[ind]);
                                },
                              );
                            },
                          );
                        }else
                          {
                            return Text('no data to view ');
                          }


                    }),
              ),
            ],
          );
        }),
      ),
    );
  }

  showModelV(context,GitHubRepo getObj){
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.insert_drive_file),
                title: new Text('name : ${getObj.name}'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.web),
                title: new Text('Full Name : ${getObj.fullName}'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.person),
                title: new Text('Owner : ${getObj.teamsUrl}'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(Icons.security),
                title: new Text('id ${getObj.id}'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
//                leading: new Icon(Icons.code),
                title: new Text('Done by Motasem Taamneh 2021',style: TextStyle(color: Colors.amberAccent),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

  }

}
