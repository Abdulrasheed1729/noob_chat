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

### Libraries and Plugins 🔌
A brief description of the libraries used.

|Name | Usage|
|---|---|
  bloc| For *Bloc* implementation
  cached_network_image| For image internet caching
  cloud_firestore| For database
  connectivity_plus| For checking connection
  file_picker| For picking file from the device
  firebase_auth| For user authentication
  firebase_core| Firebase sdk
  firebase_storage| For storing files in the cloud
  flow_builder| For authentication flow
  flutter_bloc| Flutter bloc implementation
  flutter_chat_types| Chat implementation types
  flutter_chat_ui| 
  flutter_firebase_chat_core| 
  formz| For form inputs validation
  http| 
  image_picker| Picking image from the device
  mime| File mime
  open_filex| Opening files in the device
  permission_handler| Handles device permission
  uuid| Generates random Strings


### Todos 📑
- [X] Make App work
- [ ] Update Readme
- [ ] Add screenshots to readme
- [ ] Make the design more beautiful.