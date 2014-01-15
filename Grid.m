//
//  Grid.m
//  wat0r
//
//  Created by Nicholas Colclasure on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Grid.h"


@implementation Grid

@synthesize cellSize;
@synthesize rows;
@synthesize columns;
@synthesize gridlines;


- (void)awakeFromNib {
    cellSize = 1.0;
    rows = 30;
    columns = 30;
    gridlines = NO;
}

- (void)drawRect:(NSRect)rect;
{
    int width = rect.size.width;
    int height = rect.size.height;
    NSRect curRect = NSMakeRect(0, 0, cellSize, cellSize);
    curRect.origin.x = rect.origin.x;
    curRect.origin.y = rect.origin.y;
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < rows; j++) {
            [[delegate grid:self colorOfx:i y:j] set];
            [NSBezierPath fillRect:curRect];
            curRect.origin.y += cellSize;
        }
        curRect.origin.x += cellSize;
        curRect.origin.y = rect.origin.y;
    }
    if (gridlines) {
        [[NSColor lightGrayColor] setStroke];
        NSBezierPath *drawingPath = [NSBezierPath bezierPath];
        for (int i = 0; i <= width; i += cellSize) {
            [drawingPath moveToPoint:NSMakePoint(i, 0)];
            [drawingPath lineToPoint:NSMakePoint(i, height)];
        }
        for (int i = 0; i <= height; i += cellSize) { 
            [drawingPath moveToPoint:NSMakePoint(0,i)]; 
            [drawingPath lineToPoint:NSMakePoint(width, i)];
        }
        [drawingPath stroke];
    }
}

@end