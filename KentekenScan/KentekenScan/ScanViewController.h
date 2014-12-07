//
//  ScanViewController.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingImplementation.h"
#import "ResultsTableViewController.h"
#import "ScanViewOverlay.h"

@interface ScanViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)checkPhoto:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *results;
@property (strong, nonatomic) id <ImageProcessingProtocol> imageProcessor;

@end