//
//  OpenCVWrapper.m
//  Koloria
//
//  Created by Dave on 09/10/24.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpenCVWrapper.h"

using namespace cv;

@interface UIImage (OpenCVWrapper)
- (void)convertToMat: (Mat *)pMat: (bool)alphaExists;
@end

@implementation UIImage (OpenCVWrapper)

- (void)convertToMat: (Mat *)pMat: (bool)alphaExists {
    if (self.imageOrientation == UIImageOrientationRight) {
        /*
         * When taking picture in portrait orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat, alphaExists);
        rotate(*pMat, *pMat, ROTATE_90_CLOCKWISE);
    } else if (self.imageOrientation == UIImageOrientationLeft) {
        /*
         * When taking picture in portrait upside-down orientation,
         * convert UIImage to OpenCV Matrix in landscape right-side-up orientation,
         * and then rotate OpenCV Matrix to portrait upside-down orientation
         */
        UIImageToMat([UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:UIImageOrientationUp], *pMat, alphaExists);
        rotate(*pMat, *pMat, ROTATE_90_COUNTERCLOCKWISE);
    } else {
        /*
         * When taking picture in landscape orientation,
         * convert UIImage to OpenCV Matrix directly,
         * and then ONLY rotate OpenCV Matrix for landscape left-side-up orientation
         */
        UIImageToMat(self, *pMat, alphaExists);
        if (self.imageOrientation == UIImageOrientationDown) {
            rotate(*pMat, *pMat, ROTATE_180);
        }
    }
}

@end

@implementation OpenCVWrapper

+ (NSString *) version {
    return [NSString stringWithFormat:@"OpenCV Version: %s",  CV_VERSION];
}

+ (UIImage *) toGrayscale :(UIImage *)image {
    Mat mat;
    [image convertToMat: &mat :false];
    
    Mat gray;

    if (mat.channels() > 1) {
        cvtColor(mat, gray, COLOR_RGB2GRAY);
    } else {
        mat.copyTo(gray);
    }

    UIImage *grayImg = MatToUIImage(gray);
    return grayImg;
}

+ (UIImage *) stackBlur :(UIImage *)image :(int)blurAmount {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat blur;
    mat.copyTo(blur);
    
    stackBlur(mat, blur, cv::Size(blurAmount, blurAmount));
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) medianBlur :(UIImage *)image :(int)blurAmount {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat blur;
    mat.copyTo(blur);
    
    medianBlur(mat, blur, 15);
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) bilateralFilter :(UIImage *)image {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat blur;
    mat.copyTo(blur);
    
    // Channel reducing 4->3
    cvtColor(mat, mat, COLOR_BGRA2BGR);
    bilateralFilter(mat, blur, 15, 80, 80);
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) boxFilter :(UIImage *)image {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat dst;
    mat.copyTo(dst);
    
    boxFilter(mat, dst, -1, cv::Size(16, 16));
    
    UIImage* dstImage = MatToUIImage(dst);
    return dstImage;
}

+ (UIImage *) filter2D :(UIImage *)image {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat dst;
    mat.copyTo(dst);
    
    /// value -1 indicates that the dst depth is the same as the source
    int ddepth = -1;
    
    int ind = 100000;
    int kernel_size = 3 + 2*( ind%5 );
    Mat kernel = Mat::ones( kernel_size, kernel_size, CV_32F )/ (float)(kernel_size*kernel_size);
    
    Mat kernel_a = (Mat_<double>(3,3) << 0, 0, 0, 1, 1, 1, 0, 0, 0);
    Mat kernel_b = Mat::ones(5, 5, CV_64F);
    
    filter2D(mat, dst, ddepth, kernel_b);
    
    UIImage* dstImage = MatToUIImage(dst);
    return dstImage;
}

+ (UIImage *) flip_axes :(UIImage *)image :(int)direction {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat dst;
    mat.copyTo(dst);
    
    flip(mat, dst, direction);
    
    UIImage* dstImage = MatToUIImage(dst);
    return dstImage;
}

+ (UIImage *) gaussianBlur :(UIImage *)image :(int)blurAmount {
    Mat mat;
    [image convertToMat:&mat :false];
    
    Mat blur;
    mat.copyTo(blur);
    
    GaussianBlur(mat, blur, cv::Size(blurAmount, blurAmount), 0.0);
    
    UIImage* blurImage = MatToUIImage(blur);
    return blurImage;
}

+ (UIImage *) resize :(UIImage *)image :(int)width :(int)height :(int)interpolation {
    Mat mat;
    [image convertToMat: &mat :false];
    
    if (mat.channels() == 4) {
        [image convertToMat: &mat :true];
    }
    
    Mat resized;
    cv::Size size = {width, height};
    
    resize(mat, resized, size, 0, 0, interpolation);
    
    UIImage *resizedImg = MatToUIImage(resized);
    
    return resizedImg;
}

@end
