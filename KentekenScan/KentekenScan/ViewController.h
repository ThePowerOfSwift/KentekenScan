//
//  ViewController.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingImplementation.h"

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
//    id <ImageProcessingProtocol> imageProcessor;
}

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;
- (IBAction)openCV:(UIButton *)sender;


@end