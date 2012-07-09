/*
  GridView.m
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

#import "GridView.h"

#define determinedBlockSize GVRectMake(self.blockSize.width, self.blockSize.height)

// Dont forget the number includes 0
#define numberOfEnterAnimations 9 
#define numberOfExitAnimations 9

#define defaultDuration 0.3

@interface GridView (Private)

- (CGPoint)randomAvailablePoint;
- (CGPoint)randomTakenPoint;

@end

@implementation GridView

@synthesize gridSize = _gridSize;
@synthesize blockSize = _blockSize;
@synthesize blockType = _blockType;

- (void)awakeFromNib {
    self.gridSize = self.frame.size;
    self.blockType = GVBlockTypeDefault;
}

- (void)setBlockSize:(GVBlock)blockSize {
    _blockSize = blockSize;
    _numberX = _gridSize.width / blockSize.width;
    _numberY = _gridSize.height / blockSize.height;
    _remainingSizeX = _gridSize.width - (_blockSize.width * _numberX);
    _remainingSizeY = _gridSize.height - (_blockSize.height * _numberY);
    _grid = [[NSMutableArray alloc] init];
    for (int count = 0; count < _numberX; count++) {
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (int inner = 0; inner < _numberY; inner++) {
            [temp addObject:[NSNumber numberWithInt:0]];
        }
        [_grid addObject:temp];
    }
}

- (void)setBlockType:(GVBlockType)blockType {
    _blockType = blockType;
}

- (id)initWithGridFrame:(CGRect)frame andBlockSize:(GVBlock)blockSize {
    self = [super initWithFrame:frame];
    if (self) {
        self.gridSize = frame.size;
        self.blockSize = blockSize;
        self.blockType = GVBlockTypeDefault;
        _numberX = _gridSize.width / blockSize.width;
        _numberY = _gridSize.height / blockSize.height;
        _remainingSizeX = _gridSize.width - (_blockSize.width * _numberX);
        _remainingSizeY = _gridSize.height - (_blockSize.height * _numberY);
        _grid = [[NSMutableArray alloc] init];
        for (int count = 0; count < _numberX; count++) {
            NSMutableArray *temp = [[NSMutableArray alloc] init];
            for (int inner = 0; inner < _numberY; inner++) {
                [temp addObject:[NSNumber numberWithInt:0]];
            }
            [_grid addObject:temp];
        }
    }
    return self;
}

- (CGPoint)randomAvailablePoint {
    NSArray *available = [self availablePoints];
    if (available == nil || [available count] == 0) {
        return CGPointMake(-1, -1);
    }
    int randomIndex = arc4random_uniform([available count]);
    return [[available objectAtIndex:randomIndex] CGPointValue];
}

- (CGPoint)randomTakenPoint {
    NSArray *available = [self takenPoints];
    if (available == nil || [available count] == 0) {
        return CGPointMake(-1, -1);
    }
    int randomIndex = arc4random_uniform([available count]);
    return [[available objectAtIndex:randomIndex] CGPointValue];
}

- (NSArray *)availablePoints {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x = 0; x < _numberX; x++) {
        for (int y = 0; y < _numberY; y++) {
            if ([[_grid objectAtIndex:x] objectAtIndex:y] == [NSNumber numberWithInt:0]) {
                [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        }
    }
    return array;
}

- (NSArray *)takenPoints {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int x = 0; x < _numberX; x++) {
        for (int y = 0; y < _numberY; y++) {
            if ([[_grid objectAtIndex:x] objectAtIndex:y] != [NSNumber numberWithInt:0]) {
                [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
            }
        }
    }
    return array;
}

// --------- Insert Object with No Animation

- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point error:(NSError **)error {
    return [self insertObject:object atPoint:point withAnimation:GVAnimationNone andWithAnimationDuration:0.0 error:error];
}

- (BOOL)insertObjectAtRandomPoint:(UIView *)object error:(NSError **)error {
    return [self insertObject:object atPoint:[self randomAvailablePoint] withAnimation:GVAnimationNone andWithAnimationDuration:defaultDuration error:error];
}

// --------- Insert Object with Animation and Default Duration

- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GVEnterAnimation)animation  error:(NSError **)error {
    return [self insertObject:object atPoint:point withAnimation:animation andWithAnimationDuration:defaultDuration error:error];
}

- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GVEnterAnimation)animation error:(NSError **)error {
    return [self insertObject:object atPoint:[self randomAvailablePoint] withAnimation:animation andWithAnimationDuration:defaultDuration error:error];
}

// --------- Insert Object with Animation and Custom Duration

- (BOOL)insertObjectAtRandomPoint:(UIView *)object withAnimation:(GVEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error {
    return [self insertObject:object atPoint:[self randomAvailablePoint] withAnimation:animation andWithAnimationDuration:duration error:error];
}

- (BOOL)insertObject:(UIView *)object atPoint:(CGPoint)point withAnimation:(GVEnterAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    if (point.x > (_numberX - 1) || point.y > (_numberY - 1) || point.x <= -1 || point.y <= -1) {
        [errorDetail setValue:@"Point is out of range, or the Grid is full" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"GridView" code:100 userInfo:errorDetail];
        return NO;
    }
    if ([[_grid objectAtIndex:point.x] objectAtIndex:point.y] != [NSNumber numberWithInt:0]) {
        [errorDetail setValue:@"Space is already occupied" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"GridView" code:101 userInfo:errorDetail];
        return NO;
    }
    if (!CGSizeEqualToSize(object.frame.size, determinedBlockSize)) {
//        NSLog(@"Not the right size, adjusting for you");
        object.frame = CGRectMake(0, 0, determinedBlockSize.width, determinedBlockSize.height);
    }
    CGRect screen = [[UIScreen mainScreen] bounds];
    if (animation == GVAnimationRandom) {
        animation = arc4random_uniform(numberOfEnterAnimations);
    }
    switch (_blockType) {
        case GVBlockTypeRoundedEdges: {
            object.layer.cornerRadius = object.frame.size.width / 8.0;
            object.clipsToBounds = YES;
            break;
        } case GVBlockTypeCircle: {
            object.layer.cornerRadius = object.frame.size.width / 2.0;
            object.clipsToBounds = YES;
            break;
        } case GVBlockTypeTriangle: {
            object.layer.cornerRadius = 0;
            [self drawTriangleOnObject:object];
            break;
        } 
    }
    switch (animation) {
        case GVAnimationNone: {
            object.frame = CGRectMake(((_remainingSizeX / 2) + (point.x * object.frame.size.width)), ((_remainingSizeY / 2) + (point.y * object.frame.size.height)), object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromLeft: {
            object.frame = CGRectMake(-1, ((_remainingSizeY / 2) + (point.y * object.frame.size.height)), object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromRight: {
            object.frame = CGRectMake(screen.size.width+1, ((_remainingSizeY / 2) + (point.y * object.frame.size.height)), object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromBelow: {
            object.frame = CGRectMake(((_remainingSizeX / 2) + (point.x * object.frame.size.width)), screen.size.height+1, object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromAbove: {
            object.frame = CGRectMake(((_remainingSizeX / 2) + (point.x * object.frame.size.width)), -1, object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromBottomLeft: {
            object.frame = CGRectMake(-1, screen.size.height+1, object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromBottonRight: {
            object.frame = CGRectMake(screen.size.width+1, screen.size.height+1, object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromTopLeft: {
            object.frame = CGRectMake(-1, -1, object.frame.size.width, object.frame.size.height);
            break;
        } case GVAnimationEnterFromTopRight: {
            object.frame = CGRectMake(screen.size.width+1, -1, object.frame.size.width, object.frame.size.height);
            break;
        }
    }
    [[_grid objectAtIndex:point.x] setObject:object atIndex:point.y];
    [self addSubview:object];
    [UIView animateWithDuration:duration animations:^ {
        object.frame = CGRectMake(((_remainingSizeX / 2) + (point.x * object.frame.size.width)), ((_remainingSizeY / 2) + (point.y * object.frame.size.height)), object.frame.size.width, object.frame.size.height);
    }];
    return YES;
}

// --------- Remove Object with No Animation

- (BOOL)removeObjectAtPoint:(CGPoint)point error:(NSError **)error {
    return [self removeObjectAtPoint:point withAnimation:GVAnimationNone andWithAnimationDuration:0.0 error:error];
}

- (BOOL)removeObjectAtRandomPoint:(NSError **)error {
    return [self removeObjectAtPoint:[self randomTakenPoint] withAnimation:GVAnimationNone andWithAnimationDuration:defaultDuration error:error];
}

// --------- Remove Object with Animation and Default Duration

- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GVExitAnimation)animation error:(NSError **)error {
    return [self removeObjectAtPoint:point withAnimation:animation andWithAnimationDuration:defaultDuration error:error];
}

- (BOOL)removeObjectAtRandomPointWithAnimation:(GVExitAnimation)animation error:(NSError **)error {
    return [self removeObjectAtPoint:[self randomTakenPoint] withAnimation:animation andWithAnimationDuration:defaultDuration error:error];
}

// --------- Remove Object with Animation and Custom Duration

- (BOOL)removeObjectAtRandomPointWithAnimation:(GVExitAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error {
    return [self removeObjectAtPoint:[self randomTakenPoint] withAnimation:animation andWithAnimationDuration:duration error:error];
}

- (BOOL)removeObjectAtPoint:(CGPoint)point withAnimation:(GVExitAnimation)animation andWithAnimationDuration:(NSTimeInterval)duration error:(NSError **)error {
    NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
    if (point.x > (_numberX - 1) || point.y > (_numberY - 1) || point.x <= -1 || point.y <= -1) {
        [errorDetail setValue:@"Point is out of range, or the Grid is empty" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"GridView" code:100 userInfo:errorDetail];
        return NO;
    }
    if ([[_grid objectAtIndex:point.x] objectAtIndex:point.y] == [NSNumber numberWithInt:0]) {
        [errorDetail setValue:@"No object exsits here" forKey:NSLocalizedDescriptionKey];
        *error = [NSError errorWithDomain:@"GridView" code:100 userInfo:errorDetail];
        return NO;
    }
    CGRect screen = [[UIScreen mainScreen] bounds];
    if (animation == GVAnimationRandom) {
        animation = arc4random_uniform(numberOfExitAnimations);
    }
    UIView *removeObject = [[_grid objectAtIndex:point.x] objectAtIndex:point.y];
    [self bringSubviewToFront:removeObject];
    [UIView animateWithDuration:duration animations:^ {
        switch (animation) {
            case GVAnimationExitToLeft: {
                removeObject.frame = CGRectMake(-1, removeObject.frame.origin.y, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToRight: {
                removeObject.frame = CGRectMake(screen.size.width+1, removeObject.frame.origin.y, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToBelow: {
                removeObject.frame = CGRectMake(removeObject.frame.origin.x, screen.size.height+1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToAbove: {
                removeObject.frame = CGRectMake(removeObject.frame.origin.x, -1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToBottomLeft: {
                removeObject.frame = CGRectMake(-1, screen.size.height+1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToBottonRight: {
                removeObject.frame = CGRectMake(screen.size.width+1, screen.size.height+1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToTopLeft: {
                removeObject.frame = CGRectMake(-1, -1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            } case GVAnimationExitToTopRight: {
                removeObject.frame = CGRectMake(screen.size.width+1, -1, removeObject.frame.size.width, removeObject.frame.size.height);
                break;
            }
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [removeObject removeFromSuperview];
            [[_grid objectAtIndex:point.x] replaceObjectAtIndex:point.y withObject:[NSNumber numberWithInt:0]];
        }
    }];
    
    return YES;
}

- (void)drawTriangleOnObject:(UIView *)object {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path,NULL,object.frame.size.width/2.0,0.0);
    CGPathAddLineToPoint (path, NULL,object.frame.size.width, object.frame.size.height);
    CGPathAddLineToPoint (path, NULL,0.0f, object.frame.size.height);
    CGPathCloseSubpath(path);
    
    CAShapeLayer * mask = [CAShapeLayer layer];
    mask.path = path;
    
    [object.layer setMask:mask];
}

@end
