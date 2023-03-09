# Noob Chat 💬

[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

A simple chat 💬 app build with [**Flutter**](https://flutter.dev) by noob a noob for noobs.

### Architecture 🛠️
This app make use of the [Bloc](https://bloc.dev) architecture to separate the app locgic from the UI.
### Folder Structure 🗃️

```
├── blocs
│   ├── app
│   ├── messages
│   └── users_list
├── cubits
│   ├── connectivity
│   ├── login
│   └── sign_up
├── models
├── repositories
│   ├── auth
│   ├── chat
│   ├── connectivity_manager
│   ├── storage
│   └── user
├── utils
└── views
    ├── auth
    └── chat
```

## Libraries and Plugins 🔌
A brief description of the libraries used.

|Name | Version|
|---|---|
  bloc| ^8.1.1
  cached_network_image| ^3.2.3
  cloud_firestore| ^4.4.3
  connectivity_plus| ^3.0.3
  cupertino_icons| ^1.0.2
  equatable| ^2.0.5
  file_picker| ^5.2.5
  firebase_auth| ^4.2.9
  firebase_core| ^2.7.0
  firebase_storage| ^11.0.14
  flow_builder: ^0.0.9
  flutter_bloc| ^8.1.2
  flutter_chat_types| ^3.6.0
  flutter_chat_ui| ^1.6.6
  flutter_firebase_chat_core| ^1.6.4
  formz| ^0.4.1
  http| ^0.13.5
  image_picker| ^0.8.6+3
  mime| ^1.0.4
  open_filex| ^4.3.2
  page_transition | ^2.0.9
  permission_handler| ^10.2.0
  uuid| ^3.0.7

