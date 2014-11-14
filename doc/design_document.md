# Design document

This is the design document for the KentekenScan app.

## Description

This app uses the built-in camera to take a picture. Thereafter, the picture is analysed to see if a license plate can be detected and identified.

## Classes and public methods

### Model

- NSMutableArray to keep track of the recognized license plate characters.
- Extra information is needed for built-in camera, OpenCV and tesseract use.

### View

- WelcomeView: subclass of UIView that contains:
    - UITextView for the intro text.
    - UIButton to go to the second screen.
- CameraView: sublcass of UIView that contains:
    - UIImageView for the camera view.
    - Two UIButtons to approve or disapprove the photo.
    - UIAlertView to display the recognized license plate characters, with options to approve or disapprove the recognized characters. 
- ResultsView: subclass of UITableView that contains:
    - UITableViewCells with each a UIView that contains a UILabel with license plate characters

### Controller

- WelcomeViewController: subclass of UIViewController to display the welcome screen.
- CameraViewController: subclass of UIViewController to display the camera view, the approve/dissapprove buttons and the alert that displays the recognized license plate characters.
- ResultsViewController: subclass of UITTableViewController to display all scanned and recognized license plate characters.
- NavigationController: subclass of UINavigationController to navigate between the different screens as shown in the wireframe.

## APIs and frameworks

- built-in camera to take a picture.
- OpenCV to detect a license plate.
- Tesseract OCR to identify the detected license plate as characters.

## Wireframe
![wireframe](https://github.com/jetsekoopmans/KentekenScan/blob/master/doc/wireframe.png)

## Optional
Display information about the recognized license plate found on ovi.rdw.nl.