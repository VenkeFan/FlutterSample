import 'dart:io';
import 'dart:convert';

typedef void RequestFinishedCallBack(Map<String, dynamic> responseObject, String errorInfo);

class BasicRequest {
  requsetDiscovery(RequestFinishedCallBack finished) async {
    const url =
        "https://api.welike.in/leaderboard/skip/rising?welikeParams=dmU9Mi4yLjQmbGE9ZW4mb3M9aW9zJmRlPUE5Njg5QTA3QzZDNDQxMzNCRUUyMTRCQTlGODYwMzVCJnNyPWlQaG9uZTgsMQ==&count=15&interests=%5B59%5D&gid=A9689A07C6C44133BEE214BA9F86035B&userType=vidmate";
    var httpClient = new HttpClient();

    String errorInfo;
    Map<String, dynamic> responseObj;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        if (data == null) {
          errorInfo = "Error: data == null";
        }

        dynamic code = data["code"];
        if (code == null || code != 1000) {
          errorInfo = "Error: code != 1000";
        }

        if (errorInfo == null) {
          responseObj = data["result"];
          print("*************************** responseObj success");
        }
        
      } else {
        errorInfo = 'Error: Http status ${response.statusCode}';
      }
    } catch (exception) {
      errorInfo = 'Exception: $exception';
    }
    httpClient.close();
    
    if (finished != null) {
      finished(responseObj, errorInfo);
    }
  }
}
