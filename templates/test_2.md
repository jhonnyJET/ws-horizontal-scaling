
### 2nd Test case.

Curl command to batch connect 7 users to the ws-app application.
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
        "user7"
    ]
}'
```

## Curl command to batch connect 2 users to the ws-app application.

```
curl --location --request POST 'http://<YOUR_HOST>:8089/route/kickstart/ws/batch/connect' \
--header 'Content-Type: application/json' \
--data '{
    "userIds": [
        "user8",
        "user9"
    ]
}'
```

## Curl command to batch disconnect all 9 users from the ws-app application (Please replace YOUR_HOST by your host address)

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
        "user9"
    ]
}'
```