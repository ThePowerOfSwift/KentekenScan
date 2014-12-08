//
//  ScanViewController.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//
//  Code for the ViewController to handle the photo stuff.
//

#import "ScanViewController.h"
#import "ScanViewOverlay.h"

@interface ScanViewController () {
    NSString *result;
}

@end

@implementation ScanViewController
@synthesize results;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.results = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"defaults_results"]) {
        self.results = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"defaults_results"]];
    }
    
    self.imageProcessor = [ImageProcessingImplementation new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"image_sample.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// When picked photo is cancelled
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// When image is picked
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image;
    
    // Check if there is a cropped image
    if (info[UIImagePickerControllerEditedImage]) {
        image = info[UIImagePickerControllerEditedImage];
    }
    else {
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    self.imageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// Go to camera view if it is available
- (IBAction)takePhoto:(UIButton *)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls = NO;
        picker.navigationBarHidden = YES;
        picker.toolbarHidden = YES;
        
        // calculate the ratio that the camera height needs to be scaled by
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        float scale = screenSize.height / screenSize.width;
        picker.cameraViewTransform = CGAffineTransformMakeScale(scale, scale);

        // Set custom camera view
        ScanViewOverlay *overlay = [[ScanViewOverlay alloc] customViewForImagePicker:picker];
        picker.cameraOverlayView = overlay;

        [self presentViewController:picker animated:YES completion:NULL];
    }
    else {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Back"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}

// Select photo from library
- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Process image, detect characters and alert the result
- (IBAction)checkPhoto:(UIButton *)sender {
    UIImage *processedImage;
    
    processedImage = [self.imageProcessor processImage:self.imageView.image];
    result = [self.imageProcessor OCRImage:processedImage];

    // Check if result is empty
    UIAlertView *myAlertView;
    if ([result isEqualToString:@""]) {
        myAlertView = [[UIAlertView alloc] initWithTitle:@"Resultaat"
                                                 message:@"Geen kenteken herkend. Probeert u het nogmaals."
                                                delegate:self
                                       cancelButtonTitle:@"Ok"
                                       otherButtonTitles:nil];
    } else {
        myAlertView = [[UIAlertView alloc] initWithTitle:@"Resultaat"
                                                 message:result
                                                delegate:self
                                       cancelButtonTitle:@"Fout"
                                       otherButtonTitles:@"Goed", nil];
    }
    
    [myAlertView show];
}

// User clicked one of the "goed" button from alert
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        ResultsTableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];

        [self.results addObject:result];
        tableViewController.results = self.results;
        [[NSUserDefaults standardUserDefaults] setObject:[self.results copy] forKey:@"defaults_results"];
        
        [self.navigationController pushViewController:tableViewController animated:YES];
    }
}

// Pass data via segue to table view
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTableView"]) {
        ResultsTableViewController *tableViewController = segue.destinationViewController;
        tableViewController.results = self.results;
    }
}
@end
