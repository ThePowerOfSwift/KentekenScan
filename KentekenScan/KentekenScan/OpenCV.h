//
//  OpenCV.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_OpenCV)

+(UIImage *)MatToUIImage:(const cv::Mat&)cvMat;

@property(nonatomic, readonly) cv::Mat CVMat;

@end
