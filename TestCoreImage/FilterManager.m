//
//  FilterManager.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "FilterManager.h"
@import CoreImage;

NSString * const kInputParamRect = @"inputRectangle";

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
-(NSArray*)allFilterNames{
    return [CIFilter filterNamesInCategory:kCICategoryColorEffect];
   
}

-(UIImage*)applyFilterWithName:(NSString*)name toImage:(UIImage*)image{
    return [self applyFilterWithName:name param:nil toImage:image];
}

-(UIImage*)applyFilterWithName:(NSString*)name param:(NSDictionary*)dict toImage:(UIImage*)image{
    CIFilter *filter =  [self filterWithName:name params:dict];
    return [self applyFilter:filter toImage:image];
    
}


#pragma mark - Private
-(CIFilter*) filterWithName:(NSString*)name params:(NSDictionary*)dict{
    CIFilter *filter = [CIFilter filterWithName:name];
    //TODO: params
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
