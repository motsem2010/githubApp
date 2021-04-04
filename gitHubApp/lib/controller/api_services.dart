import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:github_app/model/gethub_repo_obj.dart';
class ApiServices {
  static Future<List<GitHubRepo>> obtainJson(String postsView) async {
    List<GitHubRepo> list = [];
    String postsURL =
        'https://api.github.com/users/${postsView}/repos';
//    final response = await get(postsURL); //1
    final response = await Dio().get(postsURL); //1
//    print(response.toString());
    if(response.statusCode==200){
      List<dynamic> x = response.data;
      for (var item in x){
        print('${item['name']}, ${item['full_name']} , ${item['id']}, ${item['private']}, ${item['owner']['login']}, ${item['node_id']}');
        list.add(GitHubRepo(name:item['name'], fullName:item['full_name'] ,id: item['id'], private:item['private'],teamsUrl: item['owner']['login'], nodeId:item['node_id']));

      }
    }

    return list; //6
  }
  static Future<String> auth_service(String username,String password) async {
   String ret_str='';
   String encod=base64Encode(utf8.encode('$username:$password'));
   String basicAuth =
       'Basic ' + encod;
   print(basicAuth);
   Dio dio = new Dio();
   dio.options.headers['content-Type'] = 'application/json';
   dio.options.headers["authorization"] = "basicAuth";

   final  r = await dio.get('https://api.github.com',
//       headers: {'authorization': basicAuth}
).timeout(Duration(milliseconds: 3000),onTimeout: (){
  ret_str='timeOut';
  return;
   });
   print(r.statusCode);
   print(r.toString());

    if(r.statusCode==200){
      ret_str='ok';

    }else
      {
        ret_str='bad';

      }

    return ret_str; //6
  }
  static String get_str_btwn(String str_to_parse, String suff, String prefx) {
    int start_indx = -1,
        last_indx = -1;
    start_indx = str_to_parse.indexOf(suff);
    last_indx = str_to_parse.indexOf(prefx);
    if (start_indx != -1 && last_indx != -1) {
      return str_to_parse.substring(
          start_indx + suff.length + 1, last_indx + 3);
    } else {
      return '';
    }
  }
}