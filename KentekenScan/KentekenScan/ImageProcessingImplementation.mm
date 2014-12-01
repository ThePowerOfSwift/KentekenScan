//
//  ImageProcessingImplementation.mm
//  KentekenScan
//
//  Created by Jetse Koopmans on 14/11/14.
//  Copyright (c) 2014 Lepps. All rights reserved.
//

#import "ImageProcessingImplementation.h"
#import "UIImage+OpenCV.h"
#import <TesseractOCR/TesseractOCR.h>

@implementation ImageProcessingImplementation

- (NSString*)OCRImage:(UIImage*)src
{
    Tesseract* tesseract;
    
    tesseract = [[Tesseract alloc] initWithLanguage:@"nld"];

    [tesseract setVariableValue:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-." forKey:@"tessedit_char_whitelist"];
    [tesseract setVariableValue:@"7" forKey:@"tessedit_pageseg_mode"];
    [tesseract setImage:src];
    [tesseract recognize];
    
    NSString *recognizedText = [tesseract recognizedText];
    recognizedText = [recognizedText
                                     stringByReplacingOccurrencesOfString:@"-" withString:@""];
    recognizedText = [recognizedText
                                     stringByReplacingOccurrencesOfString:@"." withString:@""];
    recognizedText = [recognizedText
                      stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@", recognizedText);
    return recognizedText;
}

- (UIImage*)processImage:(UIImage*)src
{
    cv::Mat source = [src CVMat];
    
    /* Pre-processing */
    
    cv::Mat img_gray;
    cv::cvtColor(source, img_gray, 6);
    blur(img_gray, img_gray, cv::Size(5,5));
//MEDIANBLUR
    medianBlur(img_gray, img_gray, 9);
    cv::Mat img_sobel;
    cv::Sobel(img_gray, img_sobel, CV_8U, 1, 0, 3, 1, 0, cv::BORDER_DEFAULT);
    cv::Mat img_threshold;
    threshold(img_gray, img_threshold, 0, 255, cv::THRESH_OTSU+cv::THRESH_BINARY);
//    cv::Mat element = getStructuringElement(cv::MORPH_RECT, cv::Size(3, 3) );
    cv::Mat element = getStructuringElement(cv::MORPH_RECT, cv::Size(7, 3) );
    morphologyEx(img_threshold, img_threshold, 3, element);
    
    /* Search for contours */
    
    std::vector<std::vector<cv::Point> > contours;
    cv::Mat contourOutput = img_threshold.clone();
    cv::findContours( contourOutput, contours, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_SIMPLE );
    
    std::vector<cv::Vec4i> hierarchy;
    
    /* Get the largest contour (Possible license plate) */
    
    int largestArea = -1;
    std::vector<std::vector<cv::Point> > largestContour;
    
    std::vector<std::vector<cv::Point> > polyContours( contours.size() );
    
    //std::vector<cv::Point> approx;
    for( int i = 0; i < contours.size(); i++ ){
        approxPolyDP( cv::Mat(contours[i]), polyContours[i], arcLength(cv::Mat(contours[i]), true)*0.02, true );
        
        if (polyContours[i].size() == 4 && fabs(contourArea(cv::Mat(polyContours[i]))) > 1000 && isContourConvex(cv::Mat(polyContours[i]))){
            double maxCosine = 0;
            
            for (int j = 2; j < 5; j++){
                double cosine = fabs(::angle(polyContours[i][j%4], polyContours[i][j-2], polyContours[i][j-1]));
                
                maxCosine = MAX(maxCosine, cosine);
            }
            
            if (maxCosine < 0.3)
                NSLog(@"Square detected");
        }
        
    }
    
    for( int i = 0; i< polyContours.size(); i++ ){
        
        int area = fabs(contourArea(polyContours[i],false));
        if(area > largestArea){
            largestArea = area;
            largestContour.clear();
            largestContour.push_back(polyContours[i]);
        }
        
    }
    
    // Contour drawing debug
    cv::Mat drawing = cv::Mat::zeros( contourOutput.size(), CV_8UC3 );
    if(largestContour.size()>=1){
        
        cv::drawContours(source, largestContour, -1, cv::Scalar(0, 255, 0), 0);
        
    }
    
    /* Get RotatedRect for the largest contour */
    
    std::vector<cv::RotatedRect> minRect( largestContour.size() );
    for( int i = 0; i < largestContour.size(); i++ )
        minRect[i] = minAreaRect( cv::Mat(largestContour[i]) );
    
    cv::Mat drawing2 = cv::Mat::zeros( img_threshold.size(), CV_8UC3 );
    for( int i = 0; i< largestContour.size(); i++ ){
        
        cv::Point2f rect_points[4]; minRect[i].points( rect_points );
        for( int j = 0; j < 4; j++ ){
            line( drawing2, rect_points[j], rect_points[(j+1)%4], cv::Scalar(0,255,0), 1, 8 );
            
        }
        
    }
    
    /* Get Region Of Interest ROI */
    
    cv::RotatedRect box = minAreaRect( cv::Mat(largestContour[0]));
    cv::Rect box2 = cv::RotatedRect(box.center, box.size, box.angle).boundingRect();
    
    box2.x += box2.width * 0.028;
    box2.width -= box2.width * 0.05;
//    box2.y += box2.height * 0.25;
//    box2.height -= box2.height * 0.55;
    box2.y += box2.height * 0.15;
    box2.height -= box2.height * 0.20;
    cv::Mat cvMat = img_threshold(box2).clone();
    
    UIImage *filtered=[UIImage MatToUIImage:cvMat];
    return filtered;
}

double angle( cv::Point pt1, cv::Point pt2, cv::Point pt0 )
{
    double dx1 = pt1.x - pt0.x;
    double dy1 = pt1.y - pt0.y;
    double dx2 = pt2.x - pt0.x;
    double dy2 = pt2.y - pt0.y;
    return (dx1 * dx2 + dy1 * dy2)/sqrt((dx1 * dx1 + dy1 * dy1) * (dx2 * dx2 + dy2 * dy2) + 1e-10);
}

@end
