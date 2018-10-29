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
-d '{"score":1337,"playerName":"Sean Plott","cheatMode":false}' \
http://localhost:1337/parse/classes/GameScore
```


