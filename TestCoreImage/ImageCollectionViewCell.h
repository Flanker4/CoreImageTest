//
//  ImageCollectionViewCell.h
//  TestCoreImage
//
//  Created by Boyko Andrey on 10/11/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
-(void) setImage:(UIImage*)image alreadyFiltered:(BOOL)filtered;
@end
