//
//  FilterManager.h
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;@import UIKit;
@interface FilterManager : NSObject
+(instancetype)sharedFilterManager;
-(UIImage*)applyFilterWithName:(NSString*)name toImage:(UIImage*)image;
@end
