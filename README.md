# Koloria
App for applying filters to images using SwiftUI, Cocoa Touch and OpenCV

## Use case

The app applies some filters to images by leveraging image processing

## Screenshots

<img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/01.png" alt="Screen 1" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/02.png" alt="Screen 2" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/03.png" alt="Screen 3" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/04.png" alt="Screen 4" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/05.png" alt="Screen 5" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/06.png" alt="Screen 6" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/07.png" alt="Screen 7" width="200"> <img src="https://github.com/dave-testaverde/Koloria/blob/main/screen/08.png" alt="Screen 8" width="200"> 

## Run project

Install OpenCV

- Download the latest OpenCV iOS Pack from its [releases](https://opencv.org/releases/)
- Extract the zip file and get `opencv2.framework` file
- Drag and drop `opencv2.framework` file into the project navigator pane
- For `Destination` check `Copy items` if needed, for `Added folders` check `Create groups` option and for `Add to targets` check your target app
- Go to `Build Phases -> Link Binary With Libraries` and you should be able to see `opencv2.framework` there
- Go to `Build Settings -> Framework Search Paths` and make sure the correct directory path for `opencv2.framework` is stated there
    
