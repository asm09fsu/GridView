## Installation/Operation Instructions
#### Using Interface Builder
#### Programmatically
The use of GridView programmatically is relatively simple. First, add GridView.h/.m into your project. Then import GridView into the View you wish to use it in. You can then use the following as a reference to adding it to your project:
```objective-c
GridView *_gv = [[GridView alloc] initWithGridFrame:CGRectMake(0, 0, 320, 480) andBlockSize:CGSizeMake(40, 40)];
[self addSubview:_gv];
```
## Copyright and Licensing
Copyright © 2012, Alex Muller

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
* The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
* The Software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose and noninfringement. In no event shall the authors or copyright holders be liable for any claim, damages or other liability, whether in an action of contract, tort or otherwise, arising from, out of or in connection with the Software or the use or other dealings in the Software.
* Except as contained in this notice, the name(s) of (the) Author shall not be used in advertising or otherwise to promote the sale, use or other dealings in this Software without prior written authorization from (the )Author.

## Future Updates
* Ability to add effects to added Views, such as rounded corners, or make the view grayscale.

## Known Bugs
* ~~Views are not properly centered on the y-coordinate~~
* ~~Views are not properly centered on the x-coordinate~~
