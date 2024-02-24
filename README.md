## DeliveryApp

![alt text](https://github.com/A-dalyomer/delivery_app/blob/main/cover.jpg?raw=true)


## summary

This project is designed to accomplish The assigned task to me by a company.
I made this app utilizing my experience in the flutter framework, dart and programming concepts,
hoping it meets the requirements you needed for examining my experience.

You can check the [Changes Made] and the git log for more details of changes i made in the project.
Plus you can check the [Key features] section for what features the app provides.

But when it came to design, i could have had a more exact design measurements but with responsiveness,
but the wireframe that was designed on a website that does not provide me with any tools to get 
measurements or even colors from it, as it would have been very useful to me that i could have used
the screen_util package or a similar one for faster responsive UI development, 
so i had to work on an approximate values, I am only writing this to explain why i couldn't afford 
the exact design sizes and colors where i could.

Although this app is currently using a good architecture, but i would have preferred using the fdd
architecture, as it's better handled on larger applications than the current one.
since it separate feature components and logic in a separate folder from the other features,
meaning easier code management and faster debugging, whilst the current one is also good architecture,
it would get somewhat non ordered as the project keeps growing.

For final thoughts, we could add a log history for the user orders as we now have all the data
saved in the order provider at the last order stet.


## Changes Made

- Implemented my own API key for google maps usage.
- Analyzed the project features and wrote down the core fundamental concepts and logic components.
- Made some changes in the existing libraries paths for more convenient future editing.
- removed unused large size assets that had impact on app size.
- Started implementing the order steps one by one with UI and logic in sequence.
- Each new feature i did implement, had gone through testing and debugging for ensuring no bugs in them.
- After making sure the feature or component is working properly, i refactor the related code.
- Made centralized constants variables for easy access and edit and even more reliable usage.
- Created some core widgets which gets their logic from the parent widget only and they handle the UI.
- Logic is mainly created and handled in the two main providers "map_provider and order_provider".
- The providers are created in the "map_screen" where their logic is needed.
- Used Consumer and Selector widgets as needed to avoid unnecessary rebuilds of widgets that impacts performance.
- Maintained clean code principles when creating widgets and linking logic to them.
- Route is calculated in real time as requested on each destination add or remove.
- Provided two different ways to load the route on the map, the free OSRM API and Google maps API.
- Used DTOs for storing state objects and easily transferring them.
- Created enums for using enhancing app logic with understandable and easier to handle logic.
- Refactored the already in-project files.
- Removed the unused dependencies.
- If you notice the floating texts in the text field it's caused by the current set font in the app.
- Documented all the new implemented code.
- Extended changelog can be found at the Git history on main branch.



## Key features

- The app immediately requests location permission and loads user location
- After loading the user location, the map camera will animate to the user location
- Also sets the current pickup location on the user location 
- The top text field can be used to manually enter a pick up location, formatted as "latitude,longitude"
- Moving cross the map also immediately updates the pickup location and the location in the top text field
- After confirming the first destination, the app will calculate the route on map
- Also with the route, the total distance is also calculated in meters for appropriate fare pricing
- The app currency and cost for motor and truck rides can be easily changed from one location in the project "const_metrics"
- Adding or removing stops will immediately calculate the new route and draw it on map, and also calculate total distance
- Receiver info has form validation for the entered text
- Goods type selection will update the available rides widget with the selected category
- Selecting the ride type will affect the recommended fare price
- The offered fare price by user can be edited in two ways, one is the buttons on the sides and the other one by entering a new fare and pressing the update button
- Cancel button will cancel the active order and reset both providers states to the initial states
- A back button on the order progress UI will function as back button for the order steps and with ability to edit previous steps



## Setup Instructions

1. **Installation:**
    - Run flutter pub get
    - Run the app on an emulator or device

2. **Usage:**
    - You can use the APK that i provided with the package
    - You can build your own APK from terminal by running flutter build apk --split-per-abi --release
    - You can run the app in debug mode too

3. **Testing:**
    - Tests have been made for the core components of the task
    - Tests can be found in the tests folder in project root directory

4. **Additional Notes:**
    - In case of Google Api key i left my own one in the project for testing
    - The provided key have access to the Google maps only
    - which means it has no access to the routes API from Google console
    - Even though i used an alternative API, you can switch to test the routes from Google
    - All you need is another API key from your side, then the following:
    - Go to map_provider found at lib/services/map
    - On line "185" change the apiMode from OSRM to google

## Contributors

- Ahmad Daly omer
