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
    NSString *result;
}
@end

@implementation ViewController
//@synthesize results;

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.results = [[NSMutableArray alloc]init];
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

    result = [imageProcessor OCRImage:processedImage];
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Resultaat"
                                                          message:result
                                                         delegate:self
                                                cancelButtonTitle:@"Fout"
                                                otherButtonTitles: @"Goed", nil];
    [myAlertView show];
}

// User clicked one of the Goed/Fout buttons
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        NSLog(@"fout");
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TableViewController *tableViewController = [storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
//        tableViewController.result = result;
//        [self.results addObject:result];
        NSLog(@"Result: %@", result);
//        NSLog(@"results; @", self.results[0]);
//        NSLog(@"Array: %@",self.results);
        tableViewController.result = result;
//        NSLog(@"Array2: %@",tableViewController.results);

//        tableViewController.results = myArray;
//        tableViewController.results = [[NSMutableArray alloc] initWithObjects: @"Red", @"Yellow", @"Green", @"Blue", @"Purpole", nil];
        [self.navigationController pushViewController:tableViewController animated:YES];
    }
}
@end
