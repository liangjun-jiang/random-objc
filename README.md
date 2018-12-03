## ParseLiveQuery Issue
There are some issues with ParseLiveQuery Swift framework. Basically, Xcode 10.1 is not able to recognize some objective-C methods defined in ObjcCompat.swift.
An fix version of this file is added in the root of this project.
So have to manually replace ObjcCompat.swift in Pods with this one.



1. step 1
```
mongodb-runner start
```
2. step 2
```
parse-server --appId UA_APPLICATION_ID --masterKey UA_MASTER_KEY --clientKey UA_CLIENT_KEY --databaseURI mongodb://localhost/develop
```
3. step 3
```
curl -X POST \
-H "X-Parse-Application-Id: UA_APPLICATION_ID" \
-H "X-Parse-Client-Key: UA_CLIENT_KEY" \
-H "Content-Type: application/json" \
-d '{  
   "agentSays":"Does it work?",
   "agentThinks":"I think it won't",
   "videoSample":{  
      "objectId":"90Co3Jewns",
      "__type":"Pointer",
      "className":"Sample",
      "videoFile":{  
          "__type":"File",
          "name":"5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov",
          "url":"http://localhost:1337/parse/files/UA_APPLICATION_ID/5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov"
      },
      "owner":{  
          "__type":"Pointer",
          "className":"_User",
          "objectId":"iJXPpdKOE7"
      },
      "createdAt":"2018-11-02T06:38:28.946Z",
      "updatedAt":"2018-11-02T06:38:28.946Z",
      "ACL":{  
          "*":{  
            "read":true
          },
          "iJXPpdKOE7":{  
            "read":true,
            "write":true
          }
      }
    },
   "userName":"lj1"
}' \
http://localhost:1337/parse/classes/Message
```

{  
   "agentSays":"You are good.",
   "agentThinks":"No. not so much",
   "videoSample":{  
      "objectId":"wcQdNWhLc7",
      "videoFile":{  
          "__type":"File",
          "name":"5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov",
          "url":"http://localhost:1337/parse/files/UA_APPLICATION_ID/5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov"
      },
      "owner":{  
          "__type":"Pointer",
          "className":"_User",
          "objectId":"iJXPpdKOE7"
      },
      "createdAt":"2018-11-02T06:38:28.946Z",
      "updatedAt":"2018-11-02T06:38:28.946Z",
      "ACL":{  
          "*":{  
            "read":true
          },
          "iJXPpdKOE7":{  
            "read":true,
            "write":true
          }
      }
    },
   "userName":"lj1"
}

{  
   "objectId":"wcQdNWhLc7",
   "videoFile":{  
      "__type":"File",
      "name":"5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov",
      "url":"http://localhost:1337/parse/files/UA_APPLICATION_ID/5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov"
   },
   "owner":{  
      "__type":"Pointer",
      "className":"_User",
      "objectId":"iJXPpdKOE7"
   },
   "createdAt":"2018-11-02T06:38:28.946Z",
   "updatedAt":"2018-11-02T06:38:28.946Z",
   "ACL":{  
      "*":{  
         "read":true
      },
      "iJXPpdKOE7":{  
         "read":true,
         "write":true
      }
   }
}

{"objectId":"wcQdNWhLc7","videoFile":{"__type":"File","name":"5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01
-38-0.mov","url":"http://localhost:1337/parse/files/UA_APPLICATION_ID/5e55cba266b5d183d9c7f05d141e2ffb_2018-11-02-01-38-0.mov"},"owner":{"__type":"Pointer","className":"_User","objectId":"iJXPpdKOE7"},"createdAt":"2018-11-02T06:38:28.946Z","updatedAt":"2018-11-02T06:38:28.946Z","ACL":{"*":{"read":true},"iJXPpdKOE7":{"read":true,"write":true}}}

4. step 4
```
curl -X GET \
-H "X-Parse-Application-Id: UA_APPLICATION_ID" \
-H "X-Parse-Client-Key: UA_CLIENT_KEY" \
-H "Content-Type: application/json" \
http://localhost:1337/parse/classes/Sample
```


