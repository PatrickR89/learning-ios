# Meme Editor [iOS App] / Challenge day 90 (100 days of swift)

## Files Architecture

Files are grouped by their type for easier access. With delegates grouped with their respective files. 
Application contains extension, framework and Realm added via Cocoapods.

## Code architecture

UI is created programmaticaly, without Storyboard, mostly limited to UIViews which are rendered in their respective ViewControllers, while viewControllers contain only neccessary code for rendering. Renders which are placed in view controllers are limited to navigation and tool bars, with dynamic changes dependant on state of content via observers.
App is written in MVVM pattern, ViewModels being classes and containing their respective View's or ViewController's functionality. There is only one Model, as the application is directed only towards editing images with text content, model contains text and their state.
For cleaner code and easier accessibility throughout the code, functionalities tied to UIAlertController, UIImage, UIView and FileManager are added as their extensions and called on their instances. UIView and FileManager extensions are placed in app's framework to make them shared between app and it's extension.

## Data Storing

Images are stored via FileManager, while all of the information about them is saved in Realm. Realm contains own model, which contains more detailed information about the image and it's content.
Both Realm and FileManager code are placed in framework in order to avoid duplication of code for app's extension.
All images larger than 1024x1024 are reduced to that maximum resolution keeping their aspect ratio. Reduction is implemented for three main reasons, of which first is that usage and the idea of memes do not require high-resolution images. Second, for less space occupation by created memes, and third faster render and sharing.

## UI

Application's main screen contains Collection View, which lists all created memes, by tap on a meme a detail view is renedered. Main screen contains also a right bar button for adding new memes, which is achieved through opening detail view without any meme.
Image can be opened by tapping on image frame, which then initiates UIImagePickerController, with asked permission to access gallery. Text can be added on both top and bottom, by tapping top or bottom of the image, if image is loaded. Editing can be done by using toolbar buttons.
Text is rendered with CoreGraphic over the image, but keeping it as a separate component until view is closed. 
After closing view, created text is embedded into the image also using CG, and image is saved. Until that moment text can be changed infinite times. Application stores information about added texts, and in case only one position was added, second can be added later.

UI is dynamic, with enabled/disabled actions depending on current state of image and text content. For example, if no text is added, text edit is disabled, or if no image is loaded, adding text or sharing meme are disabled.

## App Extension

Application contains a single and simple extension, by help of which images can be loaded into application directly from gallery. Image is opened in new window, where action can be completed or discarded. Extension saves images with use of FileManager, and stores data about the image in Realm. All loaded images with the extension are also limited to 1024x1024 resolution.

## Notifications

For simple practice a notification alert was added, which creates a reminder for 24 hours after last meme edit, either to finish the meme, or share depending on meme's state. With start of main screen, app registers in NotificationAlert, a class created with import of UserNotifications. And with editing meme, a schedule is set for a reminder.

## Conclusion

Application was a part of the course challenges, although possibly not meant to be expanded in a way as it ended up. Mostly ideas were given by my mentor.
For example, original project did not contain extension or share in project definition. All the code is uploaded to Bitbucket, were it was supervised, with issues and tasks created for and during application development. 
