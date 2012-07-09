//
//  GridBrain.h
//  TestGrid
//
//  Created by Alex Muller on 7/6/12.
//  Copyright (c) 2012 Alex Muller. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    GridAnimationNone = 0,
    GridAnimationEnterFromLeft = 1,
    GridAnimationEnterFromRight = 2,
    GridAnimationEnterFromBelow = 3,
    GridAnimationEnterFromAbove = 4,
    GridAnimationEnterFromBottomLeft = 5,
    GridAnimationEnterFromBottonRight = 6,
    GridAnimationEnterFromTopLeft = 7,
    GridAnimationEnterFromTopRight = 8,
    GridAnimationRandom = 9
};
typedef NSUInteger GridEnterAnimation;

enum {
    GridAnimationExitToLeft = 1,
    GridAnimationExitToRight = 2,
    GridAnimationExitToBelow = 3,
    GridAnimationExitToAbove = 4,
    GridAnimationExitToBottomLeft = 5,
    GridAnimationExitToBottonRight = 6,
    GridAnimationExitToTopLeft = 7,
    GridAnimationExitToTopRight = 8
};
typedef NSUInteger GridExitAnimation;

@interface GridView : UIView {
    int _numberX;
    double _remainingSizeX;
    int _numberY;
    double _remainingSizeY;
    NSMutableArray *_grid;
}

@property (nonatomic) CGSize gridSize;
@property (nonatomic) CGSize blockSize;

- (id)initWithGridFrame:(CGRect)frame andBlockSize:(CGSize)blockSize;

- (void)setBlockSize:(CGSize)blockSize;

// Inserts object into the Grid, with GridAnimationNone and Duration 0.0
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object error:(NSError **)error;
// Inserts object into the Grid, with default Duration of 0.3
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GridEnterAnimation)animation error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GridEnterAnimation)animation error:(NSError **)error;
// Inserts object into the Grid, with custom Animation and Duration
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GridEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GridEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;


- (NSArray *)availablePoints;
- (NSArray *)takenPoints;

// Removes object from the Grid, with GridAnimationNone and Duration 0.0
- (BOOL)removeObjectAtPoint:(CGPoint)point error:(NSError **)error;
- (BOOL)removeObjectAtRandomPoint:(NSError **)error;
// Removes object from the Grid, with default Duration of 0.3
- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GridExitAnimation)animation error:(NSError **)error;
- (BOOL)removeObjectAtRandomPointWithAnimation:(GridEnterAnimation)animation error:(NSError **)error;
// Remove object from the Grid, with custom Animation and Duration
- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GridExitAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;
- (BOOL)removeObjectAtRandomPointWithAnimation:(GridEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;

@end
