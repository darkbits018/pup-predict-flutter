# Pup-Predict
- clone the pup-predict-flutter repository
```
git clone https://github.com/darkbits018/pup-predict-flutter.git
```
- clone pup-predict-backend 
```
git clone https://github.com/darkbits018/pup-predict-backend.git
```
## Prerequisite
1 Android Studio\
2 Flutter SDK\
3 PyCharm\
4 Ngrok (to forward a local port to domain)

## Instruction
- Open the Flutter app preferably using Android Studio
- Build the app
- Install and run Ngrok
- Once the Ngrok has been set up you can get a free domain
- Forward the local port 80 to that domain
    ```
    ngrok http --domain=<YOUR-NGROK-DOMAIN> <PORT>
    ```
    ![ngrok domain](https://github.com/darkbits018/pup-predict-flutter/blob/main/images/NGROK.jpg)
- Replace the "NGROK-URL" in main.dart with your Ngrok domain
    ![url](https://github.com/darkbits018/pup-predict-flutter/blob/main/images/url.jpg)

- Replace "YOUTUBE-API-KEY" in videoscreen.dart with your YouTube API key
    ![Api](https://github.com/darkbits018/pup-predict-flutter/blob/main/images/api.png)

- Open the backend directory in PyCharm
- Install libraries using requirments.txt
- Run doggos.py
- Once the server starts, the app is ready to work

## Screenshots
**Image Selection Screen**
![]()
