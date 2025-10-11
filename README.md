# Weather App

## Introduction

This project was my first attempt at a full fledged app. I've recently grown in love with iOS development & swift (check out this [repo](https://github.com/caleb-wo/Develop-In-Swift-Tutorials)).  I worked on it whenever I had time between work, school, exercise, spending time with my wife, & other projects I'm working on.

 If you have any tips for me, please let me know! This project is officially completed.

## App Showcase

<div align="center">
    <img src="./Showcase/app_demo.gif" alt="See demo in Showcase directory." height="700">
    <br>
    <sup>Note: the <strong>.gif</strong> diminishes some smoothness & quality.</sup>
</div>


## Goals

- **[COMPLETED]** Set up API service (see API info below)
- **[COMPLETED]** Built decodable types to map API JSON data. Consists of minimal types meant to descend the JSON hierarchy to the needed data.
- **[COMPLETED]** Created exstension for primary API type which decodes the key data. The exstension is a static variable which provides mock data for development & previews.
- **[COMPLETED]** Main page styling

  - [x] Forecast Day page

  - [x] .sheet view for settings & user preferences
- **[COMPLETED]** Implement SwiftData with UserRecord model that keeps track of Farenheit/Celsuis pref's & user's saved zipcodes.
- **[COMPLETED]** Utilize tasks to asynchronously fetch data upon selected zipcode change.
- **[COMPLETED]** Day weather data focus page

## Technology

- Xcode

- Swift & SwiftUI

- [Free Weather API](https://www.weatherapi.com/) (API free tier allows me only 3 forecast days)

## Knowledge

- Apple's [Swift documentation](https://developer.apple.com/documentation/swift)

- Apple's [SwiftUI documentation](https://developer.apple.com/documentation/swiftui)

- [Corner concentricity in SwiftUI on iOS 26](https://nilcoalescing.com/blog/ConcentricRectangleInSwiftUI/)

- [Gemini](https://gemini.google.com/app);

  - _note: as a matter of principle, when learning I **do not** let AI write any code for me. It is only used as a tutor. I made a custom Gemini Gem called "Swift & iOS Development Tutor." Here's the instructional prompt I've written for it:_

  - _```"You are a Swift, SwiftUI, Xcode, & iOS Development tutor. I am a college student who loves mobile development. I'm eagerly learning all of iOS Development: Swift, SwiftUI, & Xcode—I will be asking you questions. Please answer in a detailed & informative way to teach me concepts. It's important to me to learn the idiomatic ways to do things; I want to know the industry standards. If you teach me about a more obscure feature or functionality (e.g. a SwiftUI keyword that I might mistake for being a part of the Swift programming language as a whole), let me know if that feature belongs to Swift or SwiftUI. Above all else, don't just code for me. Teach me & guide me."```_

- Helpful YouTube videos:

  - [WWDC24: Meet Swift Testing | Apple](https://www.youtube.com/watch?v=WFnkNcvLnCI) –> my introdution to Swift Testing.

  - [WWDC24: Go further with Swift Testing | Apple](https://www.youtube.com/watch?v=bOvWGHi-BxI&t=129s) –> to show me further capabilites.

  - [Xcode 16 Debugging Tutorial for Beginners (2025)](https://www.youtube.com/watch?v=ZJmUeOT6c-Y)

  - [Sean Allen](https://www.youtube.com/@seanallen) –> Massive number of tutorial videos for Swift, SwiftUI, etc.
