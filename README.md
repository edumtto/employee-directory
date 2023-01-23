## Build tools & versions used
    - Xcode 14.2

## Steps to run the app
    1. Clone the repository: "git@github.com:edumtto/employee-directory.git";
    2. Open EmployeeDirectory.xcodeproj;
    3. Build and execute.

## What areas of the app did you focus on?
    - Network layer;
    - VIP architecture.

## What was the reason for your focus? What problems were you trying to solve?
    - Network layer: to create a reusable component to make api calls;
    - VIP architecture: to break down the responsibilities in classes, simplify the data flow between them and make it more easily testable.

## How long did you spend on this project?
    - 7 to 8 hours. I wanted to spend less, but I was enjoying making some tweaks and learning a little more in the process.

## Did you make any trade-offs for this project? What would you have done differently with more time?
    - Better visual feedback for errors (more descriptive, better communication);
    - Improve constraints and layout of the table view cell;
    - Storing strings in a string file;
    - Event tracking for monitoring and accessibility adjustments may be necessary for a practical project.
    

## What do you think is the weakest part of your project?
    - The view controller class is still dealing with many responsibilities. Ex: A separated reusable component would be created to be the data source of the table view.

## Did you copy any code or dependencies? Please make sure to attribute them here!
    - SDWebImage 5.15.0 (Swift Package Manager)
    - Placeholder image from "https://www.flaticon.com/free-icon/user_456283"

## Is there any other information you’d like us to know?