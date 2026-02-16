
## Curl command to batch connect users to the ws-app application (Please replace YOUR_HOST by your host address)

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
        "user13",
        "user14",
        "user15",
        "user16",
        "user17",
        "user18",
        "user19",
        "user20",
        "user21",
        "user22",
        "user23",
        "user24",
        "user25",
        "user26",
        "user27",
        "user28",
        "user29",
        "user30",
        "user31",
        "user32",
        "user33",
        "user34",
        "user35",
        "user36",
        "user37",
        "user38",
        "user39",
        "user40"
    ]
}'
```

## Curl command to batch disconnect users from the ws-app application (Please replace YOUR_HOST by your host address)

---

```
curl --location --request POST 'http://54.91.158.74:8089/route/kickstart/ws/batch/disconnect' \
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
        "user10"              
    ]
}'
```