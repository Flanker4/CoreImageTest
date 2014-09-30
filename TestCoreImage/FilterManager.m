//
//  FilterManager.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "FilterManager.h"
@import CoreImage;


@implementation FilterManager
+(instancetype)sharedFilterManager{
    static FilterManager* _sharedFilterManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFilterManager = [FilterManager new];
    });
    return _sharedFilterManager;
}

#pragma mark - Public
-(UIImage*)applyFilterWithName:(NSString*)name toImage:(UIImage*)image{
    CIFilter *filter =  [self filterWithName:name];
    return [self applyFilter:filter toImage:image];
}

#pragma mark - Private
-(CIFilter*) filterWithName:(NSString*)name{
    name = name.lowercaseString;
    CIFilter *filter = nil;
    if ([name isEqualToString:@"crop"]) {
        filter = [CIFilter filterWithName:@"CICrop"];
        CIVector *cropRect =[CIVector vectorWithX:0 Y:0 Z: 100 W: 300];
        [filter setValue:cropRect forKey:@"inputRectangle"/*kCIAttributeTypeRectangle*/];
    }
    return filter;
}

-(CIImage*) applyFilter:(CIFilter*)filter toCIImage:(CIImage*)inputImage{
    [filter setValue:inputImage forKey:kCIInputImageKey];
    return filter.outputImage;
}

-(UIImage*) applyFilter:(CIFilter*)filter toImage:(UIImage*)image{
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    CIImage *outputImage = [self applyFilter:filter toCIImage:inputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    UIImage *finalImage =
    [UIImage imageWithCGImage:[context createCGImage:outputImage fromRect:outputImage.extent]];
    
    //UIImage *finalImage = [[UIImage alloc] initWithCIImage:outputImage];
    return finalImage;
}
@end
