/*
 GridView.h
 TestGrid
 
 Created by Alex Muller on 7/6/12.
 Copyright (c) 2012 Alex Muller. 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
 associated documentation files (the "Software"), to deal in the Software without restriction, 
 including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense
 , and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do 
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial 
 portions of the Software.
 
 The Software is provided "as is", without warranty of any kind, express or implied, including but 
 not limited to the warranties of merchantability, fitness for a particular purpose and 
 noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages 
 or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in 
 connection with the Software or the use or other dealings in the Software.
 
 Except as contained in this notice, the name(s) of (the) Author shall not be used in advertising or 
 otherwise to promote the sale, use or other dealings in this Software without prior written 
 authorization from (the )Author.
 */

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
