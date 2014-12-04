//
//  ImageProcessingImplementation.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingProtocol.h"

@interface ImageProcessingImplementation : NSObject <ImageProcessingProtocol>

- (NSString *)OCRImage:(UIImage *) src;
- (UIImage *)processImage:(UIImage *) src;
double angle (cv::Point pt1, cv::Point pt2, cv::Point pt0);

@end
