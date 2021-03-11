# Summit

**Hey everybody, Summit is my macOS menu bar application to manage virtual meeting links!**

[Check it out on the Mac App Store!](https://apps.apple.com/us/app/summit-meeting-manager/id1531813681?mt=12)

![Window Image](https://github.com/samrshi/Summit/blob/master/App%20Store%20Screenshots/Window.png)

When using Summit, there are two ways that you can add a meeting to the app.
1. You can use the in-app UI to add a recurring meeting that will be stored in the app. This is perfect for things like college classes or stand-up meetings that happen regularly each week. This way, you don't have to clog up your Calendar with meetings that happen each week.

2. You can add a one-time meeting to your Mac's system Calendar, and if you include a link for a supported virtual meeting, then Summit will automatically fetch it from your Calendar and include it in the app.

Here are some of the concepts/technologies that building Summit helped me with:
* Distributing apps on the Mac App Store
* Storing user data in UserDefaults
* Using Notification Center to update my UI when the app is opened
* Fetching Calendar events with EventKit
* Creating complex user interfaces with SwiftUI
* Crafting an ideal user experience to streamline the user's time in the app
* Making intentional design choices about how to architect my app with MVVM
