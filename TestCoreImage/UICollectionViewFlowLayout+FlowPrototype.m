//
//  UICollectionViewFlowLayout+FlowPrototype.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 10/11/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "UICollectionViewFlowLayout+FlowPrototype.h"

@implementation UICollectionViewFlowLayout (FlowPrototype)
-(id)copyWithZone:(NSZone *)zone{
    UICollectionViewFlowLayout *flow = [[[self class] allocWithZone:zone] init];
    if(flow) {
        flow.minimumLineSpacing = self.minimumLineSpacing;
        flow.minimumInteritemSpacing = self.minimumInteritemSpacing;
        flow.itemSize = self.itemSize;
        flow.scrollDirection =self.scrollDirection;
        flow.headerReferenceSize = self.headerReferenceSize;
        flow.footerReferenceSize =self.footerReferenceSize;
        flow.sectionInset = self.sectionInset;
    }
    return flow;
}
@end
