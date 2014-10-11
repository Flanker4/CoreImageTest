//
//  ImageCollectionViewCell.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 10/11/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "ImageCollectionViewCell.h"
@interface ImageCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCollectionViewCell
#pragma mark -Subclass
-(void) prepareForReuse{
    [super prepareForReuse];
    [self setLoadingActive:NO];
    self.imageView.image = nil; //???
    self.imageView.highlightedImage = nil;
    self.imageView.highlighted = NO;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.imageView.highlighted = YES;
}
-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.imageView.highlighted = NO;
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.imageView.highlighted = NO;
}

#pragma mark - Public
-(void) setImage:(UIImage*)image alreadyFiltered:(BOOL)filtered{
    self.imageView.image = image;
    if (!filtered) {
        //save original image
        self.imageView.highlightedImage = image;
    }
    
    [self setLoadingActive:!filtered];
}

#pragma mark - Private
-(void) setLoadingActive:(BOOL) loading{
    self.userInteractionEnabled = !loading;
    if (loading) {
        [self.activityIndicator startAnimating];
    }else{
        [self.activityIndicator stopAnimating];
    }
}
@end
