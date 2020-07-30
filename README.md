# DDD iOS 출석체크

1. 프로젝트 설정
- Swift5
- Xcode 11.5
- iOS 11.0 or higher
- Carthage

2. 라이브러리
- 라이브러리 버전 정보
- Firebase는 링크에서 carthage 용 라이브러리 버전 확인  ([https://firebaseopensource.com/projects/firebase/firebase-ios-sdk/carthage/](https://firebaseopensource.com/projects/firebase/firebase-ios-sdk/carthage/))
```
github "ReactiveCocoa/ReactiveCocoa" ~> 10.0
github "Alamofire/Alamofire" "5.2.1"
github "SnapKit/SnapKit" ~> 5.0.1
github "ChiliLabs/CHIPageControl" ~> 0.1.3
github "ninjaprox/NVActivityIndicatorView" ~> 4.8.0
github "Ekhoo/Device" ~> 3.2.1
github "airbnb/lottie-ios" "master"
github "alickbass/CodableFirebase"
github "raulriera/TextFieldEffects"
binary "https://dl.google.com/dl/firebase/ios/carthage/FirebaseAnalyticsBinary.json" == 6.14.0
binary "https://dl.google.com/dl/firebase/ios/carthage/FirebaseAuthBinary.json" == 6.14.0
binary "https://dl.google.com/dl/firebase/ios/carthage/FirebaseDatabaseBinary.json" == 6.14.0
binary "https://dl.google.com/dl/firebase/ios/carthage/FirebaseMessagingBinary.json" == 6.14.0
binary "https://dl.google.com/dl/firebase/ios/carthage/FirebaseStorageBinary.json" == 6.14.0
```

3. 화면 Flow
<img src="https://github.com/devssun/DDD.Attendance-iOS/blob/develop/DDD%E1%84%8E%E1%85%AE%E1%86%AF%E1%84%8E%E1%85%A6%E1%86%A8%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%ABFlow.png"/>

[DDD출첵 화면Flow.gliffy](https://github.com/devssun/DDD.Attendance-iOS/blob/develop/DDD%E1%84%8E%E1%85%AE%E1%86%AF%E1%84%8E%E1%85%A6%E1%86%A8%20%E1%84%92%E1%85%AA%E1%84%86%E1%85%A7%E1%86%ABFlow.gliffy)
