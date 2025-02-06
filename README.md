# flutter_app

A new Flutter project.

## Lists

- Item
- Item
- Item

1. Item 1
2. Item 2
3. Item 3

- [ ] Incomplete item
- [x] Complete item

```dart
// An highlighted block
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;
```
## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/to/state-management-sample).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/to/resolution-aware-images).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter apps](https://flutter.dev/to/internationalization).

Authors
:  Sergio Martinez

## Gemini API using Vertex AI in Firebase

Build AI-powered mobile and web apps and features with the  Gemini API  using  Vertex AI in Firebase

The  Vertex AI  Gemini API  gives you access to the latest generative AI models from Google: the Gemini models. If you need to call the  Vertex AI  Gemini API  directly from your mobile or web app – rather than server-side — you can use the  Vertex AI in Firebase SDKs. These client SDKs are built specifically for use with mobile and web apps, offering security options against unauthorized clients as well as integrations with other Firebase services.

With these client SDKs, you can add AI personalization to your app, build an AI chat experience, create AI-powered optimizations and automation, and much more. Source: [^1]

### How does it work?

The Vertex AI in Firebase SDKs allows you to call the Vertex AI Gemini API directly from your mobile or web app removing the need to set up a backend.

### Key Capabilities
- Multimodal input
- Growing suite of capabilities
- Security and abuse prevention for production apps
- Robust infrastructure

### Available Models
- Gemini 1.5 Flash
- Gemini 1.5 Pro
- Gemini 1.0 Pro Vision
- Gemini 1.0 Pro

### Supported I/O per model

![alt text](https://github.com/SergioAMG/FlutterApp/blob/main/assets/images/Supported%20IO%20per%20Gemini%20Model.png?raw=true)

Source [^2]

### Implementation Directions

| Steps | Description      |
|:---------| :-------------|
| Connect your app to Firebase | Register your app with your Firebase project, and then add your Firebase configuration to your app. |
| Install the SDK and initialize | Install the Vertex AI in Firebase SDK that's specific to your app's platform, and then initialize the Vertex AI service and the generative model in your app.  |
| Call the Gemini API | Call the Gemini API with either text-only or multimodal prompts to generate text output. Use more complex calls to build chat experiences or use function calling. Source [^3]|
| Prepare for production | Implement important integrations for mobile and web apps, like protecting the API from abuse with Firebase App Check and including large files in requests using Cloud Storage for Firebase URLs. |

### Technical Requirements & Installation Steps

- Development environment and Flutter with Dart 3.2.0+
- Set up a Firebase project
- Connect your app to Firebase
- Upgrade your project to use the pay-as-you-go Blaze pricing plan
- Enable the required APIs in your project (Vertex AI API and Vertex AI in Firebase API)
- Add the Flutter SDK into your project
- Initialize the Vertex AI service
- Initialize the Generative Model
- Call the Vertex AI Gemini API

### Pricing Details
- No Cost (Spark)
- Pay as you go (Blaze)

Pricing Complete Information: [Gemini API using Vertex AI in Firebase.](https://firebase.google.com/docs/vertex-ai)

[^1]: Official Documentation: [Gemini API using Vertex AI in Firebase.](https://firebase.google.com/docs/vertex-ai)
[^2]: Gemini Models I/O Support: [Supported input and output for each model.](https://firebase.google.com/docs/vertex-ai/gemini-models#input-output-comparison)
[^3]: Calling the Models: [Get started with the Gemini API using the Vertex AI in Firebase SDKs.](https://firebase.google.com/docs/vertex-ai/gemini-models#input-output-comparison)

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTg0NzIxNTUyNiwxNDE4OTc0NzQ2LDEzMj
Q3ODkxMjAsMTgzMDg1MjY4MiwxOTExODE3NjQ1LC0xMzA5MTA4
NjIyLC0xMjY1MzQ4MzY2LDE3MjgzMDE0ODYsLTI2NzU4NDExMy
wtMTIxODk2MjEyOSw2MzM5MjQ2MjBdfQ==
-->