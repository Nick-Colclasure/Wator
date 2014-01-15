//
//  Grid.h
//  wat0r
//
//  Created by Nicholas Colclasure on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Grid : NSView {
    NSInteger cellSize;
    NSInteger rows;
    NSInteger columns;
    BOOL gridlines;
    id delegate;
}

@property NSInteger cellSize;
@property NSInteger rows;
@property NSInteger columns;
@property BOOL gridlines;

@end

@protocol GridDelegate
- (NSColor *)grid:(Grid *)aGrid colorOfx:(int)x y:(int)y;
@end