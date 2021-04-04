import 'package:get/state_manager.dart';
import 'package:github_app/model/gethub_repo_obj.dart';
import 'package:flutter/material.dart';

class StatControl extends GetxController {
  var isLogged = 0.obs;
  var user_name = ''.obs;
  var token = ''.obs;
  var isLoading=false.obs;
  var statusStr=''.obs;

//  List<GitHubRepo> repo=[];
  RxList<GitHubRepo> repo = RxList<GitHubRepo>();

  updateVar() {
    isLogged.value = 1;
//  update([isLogged]);
  }

  updateListRepo(List<GitHubRepo> repoGetHub) {
    repo.value = repoGetHub.obs;
  }

Future<List<GitHubRepo>> getRepoList()async{
    return repo.value;
}

}