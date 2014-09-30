//
//  ViewController.m
//  TestCoreImage
//
//  Created by Boyko Andrey on 9/30/14.
//  Copyright (c) 2014 None. All rights reserved.
//

#import "ViewController.h"
#import "FilterManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.imageView.image = [[FilterManager sharedFilterManager] applyFilterWithName:@"crop" toImage:self.imageView.highlightedImage];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchPressed:(id)sender {
    self.imageView.highlighted = !(self.imageView.highlighted);
}

@end
