//
//  MainViewController.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//
//  Code for the ViewController to handle the photo stuff.
//

#import "MainViewController.h"

@interface MainViewController (){
    NSString *result;
}

@end

@implementation MainViewController
@synthesize results;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.results = [[NSMutableArray alloc] init];
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
        TableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
        
        [self.results addObject:result];
        
        tableViewController.results = self.results;
        
        [self.navigationController pushViewController:tableViewController animated:YES];
    }
}

// Pass data via segue to table view
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showTableView"]) {
        TableViewController *tableViewController = segue.destinationViewController;
        tableViewController.results = self.results;
    }
}
@end
