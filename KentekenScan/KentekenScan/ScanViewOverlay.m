//
//  ScanViewOverlay.m
//  KentekenScan
//
//  Created by Jetse Koopmans on 07/12/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import "ScanViewOverlay.h"

@implementation ScanViewOverlay

#define BUTTON_WIDTH_HEIGHT 120

- (UIView *)customViewForImagePicker:(UIImagePickerController *)imagePicker {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    view.backgroundColor = [UIColor clearColor];
    
    // Photobutton
    UIButton *photoButton = [[UIButton alloc] initWithFrame:CGRectMake(view.frame.size.width * 0.5 - BUTTON_WIDTH_HEIGHT * 0.5, view.frame.size.height * 0.80 - BUTTON_WIDTH_HEIGHT * 0.5, BUTTON_WIDTH_HEIGHT, BUTTON_WIDTH_HEIGHT)];
    photoButton.backgroundColor = [UIColor colorWithRed:0 green:255 blue:0 alpha:0.3];
    photoButton.layer.cornerRadius = BUTTON_WIDTH_HEIGHT * 0.5;
    
    [photoButton.titleLabel setFont:[UIFont fontWithName:@"FontAwesome" size:35]];
    [photoButton setTitle:@"" forState:UIControlStateNormal];
    [photoButton addTarget:imagePicker action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:photoButton];

    return view;
}

@end
