//
//  ViewController.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "ViewController.h"
#import "FilterManager.h"
#import "ImageCollectionViewCell.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) UIImage *originalImage;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,readonly) NSArray* filterNames;

@end

@implementation ViewController
@dynamic filterNames;

-(void) setOriginalImage:(UIImage *)originalImage{
    _originalImage = originalImage;
    [self.collectionView reloadData];
    NSIndexPath *firstInexPath =[NSIndexPath indexPathForItem:0 inSection:0];
    [self scrollToItemAtIndexPath:firstInexPath animated:NO];
}

-(NSArray*) filterNames{
    //cahe?
    return [[FilterManager sharedFilterManager] allFilterNames];
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCollectionView];
}

-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self setupCollectionView];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self selectNewPhoto];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchPressed:(id)sender {
    [self selectNewPhoto];
}

#pragma mark - UIImagePicker Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.originalImage = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UICollectionView

- (void) setupCollectionView{
    UICollectionViewFlowLayout *layout = [(UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout copy];
    
    layout.itemSize = self.collectionView.bounds.size;
    
    
    UICollectionView* col= self.collectionView;
    [self.collectionView setCollectionViewLayout:layout animated:NO completion:^(BOOL finished) {
        [self scrollToItemAtIndexPath:col.indexPathsForVisibleItems.firstObject animated:NO];
    }];
    

}
         
- (void) scrollToItemAtIndexPath:(NSIndexPath   *)path animated:(BOOL)anim{
    if (path) {
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:anim];
    }
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.filterNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setImage:self.originalImage alreadyFiltered:NO];
    [self applyAsyncFilterWithName:self.filterNames[indexPath.item] toCellAtIndexPath:indexPath];
    return cell;
}

-(void) applyAsyncFilterWithName:(NSString*)name toCellAtIndexPath:(NSIndexPath*)indexPath{
    //block context
    UIImage *originalImg = self.originalImage;
    UICollectionView* collView = self.collectionView;
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        //async apply filter
        UIImage *image = [[FilterManager sharedFilterManager] applyFilterWithName:name toImage:originalImg];
        
        if ([collView.indexPathsForVisibleItems containsObject:indexPath]){
            dispatch_async(dispatch_get_main_queue(), ^{
                //update UI
                ImageCollectionViewCell *cell = (ImageCollectionViewCell*)[collView cellForItemAtIndexPath:indexPath];
                [cell setImage:image alreadyFiltered:YES];
            });
        }
        
    });
    
}

#pragma mark - Private
-(void) selectNewPhoto{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

        [self presentViewController:picker animated:YES completion:NULL];
    }else{
        //error
    }
}
@end
