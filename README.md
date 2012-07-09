## Installation/Operation Instructions
### Using Interface Builder
### Programmatically
The use of GridView programmatically is relatively simple. First, add GridView.h/.m into your project. Then import GridView into the View you wish to use it in. You can then use the following as a reference to adding it to your project:
```objective-c
GridView *_gv = [[GridView alloc] initWithGridFrame:CGRectMake(0, 0, 320, 480) andBlockSize:CGSizeMake(40, 40)];
[self addSubview:_gv];
```
### Inserting/Removing Blocks
#### Inserting
There are many functions defined to allow for a multitude of customization when it comes to how you would like to add a view to the screen and into the Grid.
* -insertObject:(UIView *)atPoint:(CGPoint)error:(NSError **)
* -insertObjectAtRandomPoint:(UIView *)error:(NSError **)
* -insertObject:(UIView *)atPoint:(CGPoint)withAnimation:(GVEnterAnimation)error:(NSError **)
* -insertObjectAtRandomPoint:(UIView *)withAnimation:(GVEnterAnimation)error:(NSError **)
* -insertObject:(UIView *)atPoint:(CGPoint)withAnimation:(GVEnterAnimation)andWithAnimationDuration:(NSTimeInterval)error:(NSError **)
* -insertObjectAtRandomPoint:(UIView *)withAnimation:(GVEnterAnimation)andWithAnimationDuration:(NSTimeInterval)error:(NSError **)

#### Removing

## Copyright and Licensing
Copyright © 2012, Alex Muller

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
 NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES 
 OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Future Updates
* Ability to add effects to added Views, such as rounded corners, or make the view grayscale.

## Known Bugs
* ~~Views are not properly centered on the y-coordinate~~
* ~~Views are not properly centered on the x-coordinate~~
