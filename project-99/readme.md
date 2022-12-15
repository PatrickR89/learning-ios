# Memory Game [iOS App] / Challenge day 99 (100 days of swift)

My biggest project up to date in creating this readme (15/12/2022). With supervision of my mentor, with my own initiative and ideas. Challenge was defined only as a Memory game, with pairing "cards". Option of the challenge was to create the game in either SpriteKit or UIKit. I chose UIKit, as my goal is to be a app developer. Application was extended in several ways from the challenge itself.
Project does not contain Storyboard, UI is defined programmaticaly.

## File Architecture

All files are grouped by their type, with delegates saved in groups with their respective files. Within groups by type, files are also grouped by their functions and appearance within the project. App contains few Pods added via Cocoapods, namely Realm, Themes and CryptoSwift.

## Code Architecture

Code is written in MVVM pattern, with later reconstruction to add Coordinator pattern. Structure was kept clean with the help of SwiftLint, Pods excluded.
ViewModels contain functionality of their respective Views and ViewControllers, to keep the code as clean and as separated as possible, for easier readability and debugging.
To avoid possible bugs in typing, most of the states and their changes are defined with Enums, of which some conform to Realm's PersistableEnum in order to save them in RealmDB.

### Views and ViewControlles

Project contains 6 View Controllers and 15+ Views, which are separated by type and functions, and most of them are paired with their ViewModels.
In order to reduce amount of code in both Views and ViewControllers, large portion of UI rendering functions are placed in different UIViews extensions and grouped as Middleware.

### ViewModels

Most of the Views require ViewModels, which are grouped in their own group "ViewModels". Delegates grouped with their respective files, except delegate protocols which point toward Coordinators. Those protocols, to separate them from delegates to parents, are grouped as NavigationActions.
NavigationActions contain all protocols named "...Actions", by call of which change of View is initiated.

### Models

More than 15 models were used in order to avoid possible unknown state changes and outcomes including views, and store all required data in Realm. Most of the views, and all of the table cell views are initialized with models.

### Diffable DataSource

During the development, for practice, better code readability and structure all table view data sources were switched to diffable data sources. Their structure and required initializations are grouped as TableViewDiffDataSources. Only separated initialization was created for SettingsTableView, which required override of headerForSection function.

### Coordinators

As mentioned at the top, Coordinator pattern was added to the project, by the instruction from mentor. Until that point, most of views were presented as modals. Project contains two Coordinators. MainCoordinator switches between LoginViewController and MenuCoordinator.
MenuCoordinator is tasked with changing ViewControllers according to User's interaction, keeping single ViewController active at any point.
Both use same Coordinator protocol.

## UI

User interface was kept simple, with primary colors. With the exception of TableViews all of Views are written separately from ViewControllers they appear in, and are initialized in their parents.
UI is available in light or dark theme, with possible dynamic change to follow system theme, which can be set in Settings. For changing themes, Themes Pod was used, which was provided with required color codes for render, leaving open option to add new themes additionally.
View reacts to keyboard by moving up, to avoid covering inputs. Feature was enabled with the help of separate KeyboardLayoutObserver which was built with Combine. 
All of dynamic updates in the UI were switched from closure observers to Combine.

## Data Storage

For data storage Realm was used, with few models. Mainly User is saved with name, password which is hashed with CryptoSwift, and unique ID, with UUID. Database also contains Statistics of game, Times for each game level and Settings. All models are tied to User with User's unique ID. To avoid possible issues, new user cannot be saved if user's name is found in DB. 

### Code

All of Realm code is saved in two files. One being Provider, a singleton with initialization function, and second Service. 
RealmDataService is structured as singleton, to enable usage in any part of the project without need to separately import Realm. All of the interactions with DB are limited to Service. All calls to DB are wrapped in error handling do {} catch {}.

### Dynamic user change

Current user is set with Combine, from Login, and is set to nil on logout to avoid accessing data of logged out users. After user is set, all of required data is available to load. Data is loaded with Views initialization.

## Settings

Settings are rendered in TableView, with interactive custom cells separated in two groups, for game settings and account changes. All of changes made are instantly updated in DB.

### Game Settings

Three options are presented for game settings. Theme used, which is explained in UI section, Multicolor and Timer. If multicolor is disabled, all cards in game are of same color, else each pair is in their own color.
Timer enables in-game stopwatch and saving achieved times in DB.

### Account Settings

All of the account settings are password protected. Mainly to protect from someone else changing user's data, and secondly to avoid accidental changes. All inputs are presented with AlertController with Cancel option available at any step.

## Stats

### View

Stats View is rendered in TableView, with diffable data source, and custom expandable cells. First cell contains stored number of played and won games, calculating success ratio from given data. Second cell uses same structure, with pairs picked and pairs paired.
Third cell, containing times, was actually the most difficult to set up. Cell containes another Table View within self to present all achieved times by game levels.

### Structure

All cells are structured as UIStackViews, with hidding or presenting bottom view on user interaction. All cells share same top view, with different data provided on initialization. First two cells also share bottom view, as they share functions and structure, while third cell contains another table view. For cleaner code, bottom state bool is used from parent View's ViewModel to avoid reseting on Table View reload, refreshing the snapshot.

## Game

First Game View is presented as Table View with difficulty options for game. Each higher difficulty renders more cards, and less number of tries.

With selected difficulty, model is initialized setting up grid view for given game. Grid layout was used, to avoid using Collection View, with respect to purpose. 

### Top layout

Depending on game difficulty, if number of tries is set, label is rendered in top left corner presenting remaining number of tries.
If Timer is enabled in setting, will be presented in top right corner.

### Grid layout

Layout was achieved by using a number of Stack Views, number of cards per Stack View, defined by provided model. Each Card has a View Model with delegate to Stack View, which delegates to parent for each registered tap. Width and height of stacks is defined by number of stacks and screen width.

### Game Card

Each Game Card is rendered within one of Stack Views, indexed as an element of the grid. All cards contain two Views, front and back, with back being shown first, while front is revealed on tap, lead by a flip animation. If card is paired it will turn grey and remain facing toward player, else it will flip back, hidding it's front.
All game Cards keep their aspect ratio on all difficulties and all screens.
Back of the card contains only a label, to mark it as the back.
Front of the card on the other hand contains a SF Symbol, which is tinted in blue or other color depending on multicolor setting. To distinct from the background on dark themes, all cards have a gray border.

### Timer/Stopwatch

If enabled in settings, every game can be timed. Settings only enable a container for the timer, which is then enabled on game start, to avoid unnecessary usage of memory, and to respect component's life cycle.
Starting the game with timer option enabled initializes timer/stopwatch and all of it's functionalities.
In case of closing or losing the game, timer will be set to nil. In case of winning, timer's save function is called, which calls saveTime function in RealmDataService, and saves new value in DB for that difficulty, only if it is lesser than previous.
Every started game is added to total number of games in statistics. 

## Conclusion

There is a lot more to write about the application. In this readme, I wanted to present most important parts of the application, and of my own development as a developer.
Although it is a small application/game, I did my best to make it real world-y, as an app which could possibly be presented in App Store, at some point in future.
Three probably most important parts I did learn during developing this projects are definetly Combine, Diffable Data Source and Coordinator Pattern.
