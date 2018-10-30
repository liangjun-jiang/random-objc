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
-d '{"agentSays":"You are good.","agentThinks":"No. not so much","videoId":01, "userName":"abced"}' \
http://localhost:1337/parse/classes/Message
```

4. step 4
```
curl -X GET \
-H "X-Parse-Application-Id: UA_APPLICATION_ID" \
-H "X-Parse-Client-Key: UA_CLIENT_KEY" \
-H "Content-Type: application/json" \
http://localhost:1337/parse/classes/Sample
```


