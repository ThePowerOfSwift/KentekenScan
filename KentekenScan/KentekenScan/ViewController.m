//
//  ViewController.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    id <ImageProcessingProtocol> imageProcessor;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Error alert if user is in simulator
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                              message:@"Device has no camera"
//                                                             delegate:nil
//                                                    cancelButtonTitle:@"OK"
//                                                    otherButtonTitles: nil];
//        [myAlertView show];
//    }
    
    imageProcessor = [ImageProcessingImplementation new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = [UIImage imageNamed:@"image_sample.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// When picked photo is cancelled
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// When image is picked
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// Go to camera view
- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    // To disable camera controlers:
//  imagePicker.showsCameraControls = NO;

    [self presentViewController:picker animated:YES completion:NULL];
}

// Select photo from library
- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

// Process image and detect characters
- (IBAction)openCV:(UIButton *)sender {
    UIImage *processedImage;
    
    processedImage = [imageProcessor processImage:self.imageView.image];
//    self.imageView.image = processedImage;

    NSString* result = [imageProcessor OCRImage:processedImage];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Result"
                                                          message:result
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles: nil];
    [myAlertView show];
}
@end
