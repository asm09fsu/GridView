//
//  ViewController.m
//  TestGrid
//
//  Created by Alex Muller on 7/6/12.
//  Copyright (c) 2012 Alex Muller. All rights reserved.
//

#import "ViewController.h"
//#import "GridView.h"

@interface ViewController () {
    IBOutlet GridView *_brain;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_brain setBlockSize:GVSquareMake(44)];
}

- (IBAction)AddView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    double r = arc4random_uniform(255)/255.0;
    double g = arc4random_uniform(255)/255.0;
    double b = arc4random_uniform(255)/255.0;
    view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
//    UIImageView *iV = [[UIImageView alloc] initWithFrame:view.frame];
//    iV.image = [UIImage imageNamed:@"sloth"];
//    [view addSubview:iV];
    NSError *error = nil;
    [_brain setBlockType:GVBlockTypeRandom];
    if (![_brain insertObjectAtRandomPoint:view withAnimation:GVAnimationRandom error:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (IBAction)available:(id)sender {
    NSLog(@"%@", [_brain availablePoints]);
}

- (IBAction)taken:(id)sender {
    NSLog(@"%@", [_brain takenPoints]);
}

- (IBAction)remove:(id)sender {
    NSError *error = nil;
    if (![_brain removeObjectAtRandomPointWithAnimation:GVAnimationRandom error:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
