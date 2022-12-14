<div> 

# github-ios-app

## Usage
GithubApp/ClientInfo.plist 파일에 CLIENT_ID 와 CLIENT_SECRET 의 값을 넣어주세요.

```swift
<string>Client ID를 입력해주세요.</string>
<string>Client SECRET을 입력해주세요.</string>

```

만약 CLIENT_ID 와 CLIENT_SECRET 이 없을 경우 [OAuth 앱 생성 및 코드 받는 법](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app, "OAuth 앱 생성하기 link")


<br/>

### 📱 Screenshots

| 검색 | 프로필 | 로그아웃 |
|:---:|:---:|:---:|
|<img width="285" alt="image" src= https://user-images.githubusercontent.com/78426896/207589010-3d7d55e4-f649-46da-ab1b-f5f0f12c3525.png> |<img width="285" alt="image" src= https://user-images.githubusercontent.com/78426896/207589357-7731b893-a75f-4b2f-8b69-edbe372eda99.png> |<img width="285" alt="image" src= https://user-images.githubusercontent.com/78426896/207589348-43e4bc55-cb7b-4211-b9aa-5681002afcad.png>|

<br/>

### 🛠 Development Environment

<img width="77" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/iOS-15.0+-silver"> <img width="95" alt="스크린샷 2021-11-19 오후 3 52 02" src="https://img.shields.io/badge/Xcode-14.1-blue">

<br/>

### :sparkles: Skills & Tech Stack

- UIKit

<br/>

### 🎁 Library
| 라이브러리        | Version |       |
| ----------------- | :-----: | ----- |
| RxSwift           | `main` | `SPM` |
| SnapKit           | `develop` | `SPM` |
| Alamofire           | `master` | `SPM` |
  
<br/>

### :file_folder: Folder Structure
```
GithubApp
	│
  |── Screen
  │   │── Common
  │   │── Search
  │   │── Profile 
  │   └── Main
  │
  |── Model
  │   │── Search                  
  │   │── User                  
  │   │── Repository                
  │   └── UIComponent               
  │          
  └── Global 
     |── Literal
     │── Extension    
     │── Service      
     │── Support    
     │── Base     
     └── Resource
```

<br/>

### :balloon: 개발 

|        완료 여부(:heavy_check_mark:)         |        Feature         |        이슈 번호         |        커밋 링크         |
| :-----: | :-----: | :-----: | :-----: |
|  :heavy_check_mark:  | 로그인 기능 | <a href="https://github.com/Minkyeong-Ko/github-ios-app/issues/4#issue-1494295755" target="_blank">4</a> | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> |
|  :heavy_check_mark:  | 검색 기능 | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">5</a> | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> | 
|  :heavy_check_mark:  | 프로필 화면 | <a href="https://github.com/Minkyeong-Ko/github-ios-app/issues/4#issue-1494295755" target="_blank">4</a> | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> | 
|  🟡 <br/> (부분 구현 - 화면 반영 문제 미해결)  | 레파지토리 Star/Unstar | <a href="https://github.com/Minkyeong-Ko/github-ios-app/issues/4#issue-1494295755" target="_blank">4</a> | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> |
|  :heavy_check_mark:  | 실제 계정에 반영  | <a href="https://github.com/Minkyeong-Ko/github-ios-app/issues/4#issue-1494295755" target="_blank">4</a> | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> |
|  ❌  | 무한스크롤 | 해당 없음 | <a href="https://github.com/Minkyeong-Ko/ds-algorithm-study-swift/blob/main/DS%26Algorithm/DataStructure/Stack.swift" target="_blank">풀이</a> |❌🟡

