//
//  OpenCVWrapper.m
//  Koloria
//
//  Created by Dave on 09/10/24.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

@interface UIImage (OpenCVWrapper)
- (void)convertToMat: (cv::Mat *)pMat: (bool)alphaExists;
@end

@implementation UIImage (OpenCVWrapper)

- (void)convertToMat: (cv::Mat *)pMat: (bool)alphaExists {
    if (self.imageOrientation == UIImageOrientationRight) {
        /*
         * When taking picture in portrait orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat, alphaExists);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_CLOCKWISE);
    } else if (self.imageOrientation == UIImageOrientationLeft) {
        /*
         * When taking picture in portrait upside-down orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait upside-down orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat, alphaExists);
        cv::rotate(*pMat, *pMat, cv::ROTATE_90_COUNTERCLOCKWISE);
    } else {
        /*
         * When taking picture in landscape orientation,
         * convert UIImage to OpenCV Matrix directly,
         * and then ONLY rotate OpenCV Matrix for landscape left-side-up orientation
         */
        UIImageToMat(self, *pMat, alphaExists);
        if (self.imageOrientation == UIImageOrientationDown) {
            cv::rotate(*pMat, *pMat, cv::ROTATE_180);
        }
    }
}

@end

@implementation OpenCVWrapper

+ (NSString *) version {
    return [NSString stringWithFormat:@"OpenCV Version: %s",  CV_VERSION];
}

+ (UIImage *) toGrayscale :(UIImage *)image {
    cv::Mat mat;
    [image convertToMat: &mat :false];
    
    cv::Mat gray;

    if (mat.channels() > 1) {
        cv::cvtColor(mat, gray, cv::COLOR_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }

    UIImage *grayImg = MatToUIImage(gray);
    return grayImg;
}

+ (UIImage *) stackBlur :(UIImage *)image :(int)blurAmount {
    cv::Mat mat;
    [image convertToMat:&mat :false];
    
    cv::Mat blur;
    mat.copyTo(blur);
    
    cv::stackBlur(mat, blur, cv::Size(blurAmount, blurAmount));
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) gaussianBlur :(UIImage *)image :(int)blurAmount {
    cv::Mat mat;
    [image convertToMat:&mat :false];
    
    cv::Mat blur;
    mat.copyTo(blur);
    
    cv::GaussianBlur(mat, blur, cv::Size(blurAmount, blurAmount), 0.0);
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) resize :(UIImage *)image :(int)width :(int)height :(int)interpolation {
    cv::Mat mat;
    [image convertToMat: &mat :false];
    
    if (mat.channels() == 4) {
        [image convertToMat: &mat :true];
    }
    
    cv::Mat resized;
    cv::Size size = {width, height};
    
    cv::resize(mat, resized, size, 0, 0, interpolation);
    
    UIImage *resizedImg = MatToUIImage(resized);
    
    return resizedImg;
}

@end
