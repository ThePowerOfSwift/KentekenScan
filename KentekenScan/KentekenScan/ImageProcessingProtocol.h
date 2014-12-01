//
//  ImageProcessingProtocol.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

@protocol ImageProcessingProtocol <NSObject>

- (UIImage*)processImage:(UIImage*)src;
- (NSString*)OCRImage:(UIImage*)src;

@end