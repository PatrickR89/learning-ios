# Note / challenge-d74 (100 days of swift)

## File architecture

Files are grouped by their types for easier navigation, with the exception of delegates, which are saved in groups of files they are delegates of. All the names are targeted to contain as much as possible information about their content, while remaining easy to read and clean.

## Code architecture

For this application MVVM pattern was used. Although I saw examples of MVVM pattern where ViewModel is a struct and strictly contains variables and constants, like my codealong project NetflixClone (https://github.com/PatrickR89/100DaysOfSwiftAndMore/tree/main/NetflixClone), I personally prefer structure which was most often in projects I learned from. In these projects ViewModels are classes which contain all the functionality and methods of their respective ViewController or UIView, to keep those as clean as possibly with exclusive use for UI rendering only.

For dynamic changes a observer class was used, which accepts any <T> value, creates a closure, which is fired on any change to the provided value. 
Clean and readable code was maintained by SwiftLint, helping to avoid leaving whitelines, bad indentation, too short names or too long lines.

## Data storage

Data is stored as JSON, with setting the model as Codable. Data transfering to/from memory includes encoding and decoding with JSONEncode and JSONDecode. Data is saved using FileManager. All the data is loaded and stored automatically with switching views.
	
## Delegates
	
Delegates are used in two cases, to provide parent classes with changes and user interaction from child classes.
	
## UI
	
Application consists of two views. Main contains table view, which presents all loaded notes. With tap on one of them a new view is presented, enabling modification of presented note.
There is an issue with visual colors in case of dark theme on iPhone.
UI was kept simple, as the main focus was on the code and structure themselves.
