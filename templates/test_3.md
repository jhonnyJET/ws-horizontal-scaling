
### 3rd Test case.

Curl command to batch connect 13 users to the ws-app application.
---

```
curl --location --request POST 'http://<YOUR_HOST>:8089/route/kickstart/ws/batch/connect' \
--header 'Content-Type: application/json' \
--data '{
    "userIds": [
        "user1",
        "user2",
        "user3",
        "user4",
        "user5",
        "user6",
        "user7",
        "user8",
        "user9",
        "user10",
        "user11",
        "user12",
        "user13"
    ]
}'
```

## Curl command to batch disconnect 6 users from the ws-app application.

```
curl --location --request POST 'http://<YOUR_HOST>:8089/route/kickstart/ws/batch/disconnect' \
--header 'Content-Type: application/json' \
--data '{
    "userIds": [
        // ADD 6 user ids to disconnect from the same server...        
    ]
}'
```

## Curl command to batch connect a new user to the ws-app application.

```
curl --location --request POST 'http://<YOUR_HOST>:8089/route/kickstart/ws/batch/connect' \
--header 'Content-Type: application/json' \
--data '{
    "userIds": [
        "user14"
    ]
}'
```

## Curl command to batch disconnect all 14 users from the ws-app application (Please replace YOUR_HOST by your host address)

---

```
curl --location --request POST 'http://<YOUR_HOST>:8089/route/kickstart/ws/batch/disconnect' \
--header 'Content-Type: application/json' \
--data '{
    "userIds": [
        "user1",
        "user2",
        "user3",
        "user4",
        "user5",
        "user6",
        "user7",
        "user8",
        "user9",
        "user10",
        "user11",
        "user12",
        "user13",
        "user14"        
    ]
}'
```