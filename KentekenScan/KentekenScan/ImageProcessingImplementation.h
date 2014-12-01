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

- (UIImage*)processImage:(UIImage*) src;
- (NSString*)OCRImage:(UIImage*) src;

@end
