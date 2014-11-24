//
//  ImageProcessor.h
//  KentekenScan
//
//  Created by Jetse Koopmans on 19/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#ifndef __KentekenScan__ImageProcessor__
#define __KentekenScan__ImageProcessor__

#include <stdio.h>

class ImageProcessor {
    typedef struct{
        int contador;
        double media;
    } cuadrante;
    
public:
    cv::Mat processImage(cv::Mat source, float height);
    cv::Mat filterMedianSmoot(const cv::Mat &source);
    cv::Mat filterGaussian(const cv::Mat&source);
    cv::Mat equalize(const cv::Mat&source);
    cv::Mat binarize(const cv::Mat&source);
    int correctRotation (cv::Mat &image, cv::Mat &output, float height);
    cv::Mat rotateImage(const cv::Mat& source, double angle);
};

#endif /* defined(__KentekenScan__ImageProcessor__) */
