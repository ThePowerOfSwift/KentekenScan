//
//  OpenCV.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

@interface UIImage (UIImage_OpenCV)

+(UIImage *)MatToUIImage:(const cv::Mat&)cvMat;

@property(readonly, nonatomic) cv::Mat CVMat;

@end
