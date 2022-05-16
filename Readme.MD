# WeatherAppSwiftUI

The application is a simple app which displays the weather for the user's location. 

# Libraries & Tools
The application uses Swift Package Manager to handle package dependencies, so there is no additional configuration to run application. 
- lottie-ios: https://github.com/airbnb/lottie-ios
- WeatherAppLogger: https://github.com/buraktuncdev/WeatherAppLogger
- WeatherAppNetwork: https://github.com/buraktuncdev/WeatherAppNetwork
- fastlane
There is one task to run all of Unit and UI tests and generate test report. To run all tests and generate report, we should use the following command in project directory.
```sh
fastlane ios tests
```
- The last test report pushed to the repository and saved in test_output directory.

# Specifications

- Application uses the darksky weather api to fetch weather forecast data.
- Redirect to the ForecastView when user allows location permission.
- On the ForecastView, there is a Lottie animations according to the weather summary information to have good user experience.
- On the ForecastView, the user can see the current weather data, hourly forecast for 24 hours and current wind speed, humidity level and visibility information
- LoadingView is a custom view for the spinner which should be on the screen when the user is waiting the data from service. 
- Hourly forecast data is shown as horizontal scrollable card views.
- If the user doesn't allow the location permission, the application redirect to the LocationErrorView to see the alert message on the screen.
- If there is an error while fetching the data from service, AlertView should be shown.

## Application Architecture
- The application architecture is ****MVVM**** with modular architecture.
- Modular architecture used to provide separation of concerns such as Networking, Logging to use each kind of service if needed.
- WeatherAppLogger is a package that developed for logging. 
- WeatherAppNetwork is a package that developed for generic network requests.

## Unit and UI Tests

- The application has some unit and ui tests. The report file pushed to the repository. Each UI test asks location permission to the user and automatically selected according to the test case. 
