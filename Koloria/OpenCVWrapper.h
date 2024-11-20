//
//  OpenCVWrapper.h
//  Koloria
//
//  Created by Dave on 09/10/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCVWrapper : NSObject
+ (NSString *) version;
+ (UIImage *) resize :(UIImage *)image :(int)width :(int)height :(int)interpolation;
+ (UIImage *) toGrayscale :(UIImage *)image;
+ (UIImage *) gaussianBlur :(UIImage *)image :(int)blurAmount;
+ (UIImage *) stackBlur :(UIImage *)image :(int)blurAmount;
+ (UIImage *) medianBlur :(UIImage *)image :(int)blurAmount;
+ (UIImage *) bilateralFilter :(UIImage *)image;
+ (UIImage *) boxFilter :(UIImage *)image;
+ (UIImage *) dilate :(UIImage *)image;
+ (UIImage *) filter2D :(UIImage *)image;
+ (UIImage *) filter2D_a :(UIImage *)image;
+ (UIImage *) filter2D_b :(UIImage *)image;
+ (UIImage *) flip_axes :(UIImage *)image :(int)direction;
+ (UIImage *) buildPyramid :(UIImage *)image :(int)maxlevel :(int)indexElem;
@end

NS_ASSUME_NONNULL_END
