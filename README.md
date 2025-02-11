# DeepSeek clone with Vertex AI & Flutter

A DeepSeek clone created with Flutter enabled by Vertex AI  (Firebase) which allows the android chat to interact directly with Google LLM and MLLM models such as Gemini 1.5 Flash, Pro, and Pro Vision.

![alt text](https://github.com/SergioAMG/FlutterApp/blob/main/assets/images/flutter_app_2.jpg?raw=true)

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
- Gemini 1.5 Flash (Selected for this Demo)
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
a) Install Firebase CLI
b) Install flutterfire_cli
- Upgrade your project to use the pay-as-you-go Blaze pricing plan
- Enable the required APIs in your project (Vertex AI API and Vertex AI in Firebase API)
a) flutterfire configure - project
- Add the Flutter SDK into your project
a) flutter pub add firebase_core
b) flutter pub add firebase_vertexai
- Initialize the Vertex AI service
- Initialize the Generative Model
- Call the Vertex AI Gemini API

### Pricing Details
- No-Cost (Spark)
- Pay as you go (Blaze)

Complete Information Visit: [Pricing Plans and Calculator.](https://firebase.google.com/pricing)

### Code Implementation in Dart

##### main.dart
```dart
import  'package:firebase_core/firebase_core.dart';
import  'firebase_options.dart';
```
```dart
void  main() {
      runApp(const  MyApp());
      const  MyApp().initFirebase();
}
```
```dart
Future<void> initFirebase() async {
// ignore: avoid_redundant_argument_values
await Firebase.initializeApp(
      options:  DefaultFirebaseOptions.currentPlatform
);}
```

##### home_new_chat_view.dart
```dart
import  'package:firebase_vertexai/firebase_vertexai.dart';
```
```dart
  final model = FirebaseVertexAI.instance.generativeModel(model: 'gemini-1.5-flash');
  GenerateContentResponse? response;

  if (message.imagePath == null) {
    // Provide a prompt that contains text
    final prompt = [Content.text(message.text)];
    // To generate text output, call generateContent with the text input
    response = await model.generateContent(prompt);
  }
  else if (message.imagePath != null) {
    // Provide a text prompt to include with the image
    final prompt = TextPart(message.text);
    // Prepare images for input
    final image = await File(message.imagePath!).readAsBytes();
    final imagePart = InlineDataPart('image/jpeg', image);
    // To generate text output, call generateContent with the text and image
    response = await model.generateContent([
      Content.multi([prompt,imagePart])
    ]);
  }

```
![alt text](https://github.com/SergioAMG/FlutterApp/blob/main/assets/images/flutter_app.jpg?raw=true)

### Next Steps in the App life cycle
### Technical Debt / Technical Enhancements

- Secure the app (flutter and vertex ai) 
Source [^4]
- Improve the architectural structure of the app (BLoC Pattern)
- Implement modern software development best practices and patterns
- Test the app (UI tests, unit tests, usability tests, and more)
- Enable full support for multiple os, platforms, dimensions, orientation, and more 

### Business Model (Monetize App)
- Create a brand around the created app
- Develop the AI character, persona, or avatar, based on a chosen niche
- Set the unique tone of the conversation, and create rules for safe usage
- Set up the model to stay in the role despite possible attacks
- Define invisible prompts that will shape custom AI implementation
- Create pricing and service tiers
- Develop and execute digital marketing strategy for new product launch

#### AI Psychologist for children with ADHD & Autism

![alt text](https://github.com/SergioAMG/FlutterApp/blob/main/assets/images/ai_psyco.png?raw=true)


### Special Considerations and Limitations
- AI Prompt injection attacks
- AI DDoS attacks
- AI Data leaking
- Malicious URLs inside the model responses
- Social Engineering over AI
- Models over usage and API abuse
Source [^4]

[^1]: Official Documentation: [Gemini API using Vertex AI in Firebase.](https://firebase.google.com/docs/vertex-ai)
[^2]: Gemini Models I/O Support: [Supported input and output for each model.](https://firebase.google.com/docs/vertex-ai/gemini-models#input-output-comparison)
[^3]: Calling the Models: [Get started with the Gemini API using the Vertex AI in Firebase SDKs.](https://firebase.google.com/docs/vertex-ai/gemini-models#input-output-comparison)
[^4]: Securing the App: [Implement Firebase App Check to protect the Gemini API from unauthorized clients | Vertex AI in Firebase](https://firebase.google.com/docs/vertex-ai/app-check)


<!--stackedit_data:
eyJoaXN0b3J5IjpbMTc1Nzk2MDE5OSwxMzA5MTUwOTA4LC0xOT
c3MTQ1MjkyLC0zOTg4NjY5NzYsMTQ0OTUxMjM3NiwtMTA3NTk5
MTA4LC0xNzMwNDM1NDg0LC0xODE1MDM0NjIsMTI1MTQ4MzEzLD
E0MTg5NzQ3NDYsMTMyNDc4OTEyMCwxODMwODUyNjgyLDE5MTE4
MTc2NDUsLTEzMDkxMDg2MjIsLTEyNjUzNDgzNjYsMTcyODMwMT
Q4NiwtMjY3NTg0MTEzLC0xMjE4OTYyMTI5LDYzMzkyNDYyMF19

-->