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
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES 
 OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <UIKit/UIKit.h>

enum {
    GVAnimationNone = 0,
    GVAnimationEnterFromLeft = 1,
    GVAnimationEnterFromRight = 2,
    GVAnimationEnterFromBelow = 3,
    GVAnimationEnterFromAbove = 4,
    GVAnimationEnterFromBottomLeft = 5,
    GVAnimationEnterFromBottonRight = 6,
    GVAnimationEnterFromTopLeft = 7,
    GVAnimationEnterFromTopRight = 8,
    GVAnimationRandom = 9
};
typedef NSUInteger GVEnterAnimation;

enum {
    GVAnimationExitToLeft = 1,
    GVAnimationExitToRight = 2,
    GVAnimationExitToBelow = 3,
    GVAnimationExitToAbove = 4,
    GVAnimationExitToBottomLeft = 5,
    GVAnimationExitToBottonRight = 6,
    GVAnimationExitToTopLeft = 7,
    GVAnimationExitToTopRight = 8
};
typedef NSUInteger GVExitAnimation;

struct GVBlock {
    CGFloat width;
    CGFloat height;
};
typedef struct CGSize GVBlock;

@interface GridView : UIView {
    int _numberX;
    double _remainingSizeX;
    int _numberY;
    double _remainingSizeY;
    NSMutableArray *_grid;
}

@property (nonatomic) CGSize gridSize;
@property (nonatomic) CGSize blockSize;

CG_INLINE GVBlock
GVSquareMake(CGFloat width) {
    GVBlock block;
    block.width = width;
    block.height = width;
    return block;
}

CG_INLINE GVBlock
GVRectMake(CGFloat width, CGFloat height) {
    GVBlock block;
    block.width = width;
    block.height = height;
    return block;
}

- (id)initWithGridFrame:(CGRect)frame andBlockSize:(GVBlock)blockSize;

- (void)setBlockSize:(GVBlock)blockSize;

// Inserts object into the Grid, with GridAnimationNone and Duration 0.0
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object error:(NSError **)error;
// Inserts object into the Grid, with default Duration of 0.3
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GVEnterAnimation)animation error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GVEnterAnimation)animation error:(NSError **)error;
// Inserts object into the Grid, with custom Animation and Duration
- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GVEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;
- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GVEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;


- (NSArray *)availablePoints;
- (NSArray *)takenPoints;

// Removes object from the Grid, with GridAnimationNone and Duration 0.0
- (BOOL)removeObjectAtPoint:(CGPoint)point error:(NSError **)error;
- (BOOL)removeObjectAtRandomPoint:(NSError **)error;
// Removes object from the Grid, with default Duration of 0.3
- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GVExitAnimation)animation error:(NSError **)error;
- (BOOL)removeObjectAtRandomPointWithAnimation:(GVExitAnimation)animation error:(NSError **)error;
// Remove object from the Grid, with custom Animation and Duration
- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GVExitAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;
- (BOOL)removeObjectAtRandomPointWithAnimation:(GVExitAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error;

@end
