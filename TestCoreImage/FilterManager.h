//
//  FilterManager.h
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;@import UIKit;


extern NSString * const kInputParamRect;



@interface FilterManager : NSObject
+(instancetype)sharedFilterManager;

-(UIImage*)applyFilterWithName:(NSString*)name toImage:(UIImage*)image;
-(UIImage*)applyFilterWithName:(NSString*)name param:(NSDictionary*)dict toImage:(UIImage*)image;
@end
