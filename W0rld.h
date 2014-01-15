//
//  w0rld.h
//  wat0r
//
//  Created by Nicholas Colclasure on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#define maxRadius 5

struct square {
    int numfish;
    int numsharks;
    BOOL targeted;
    BOOL seen;
    float fish[10];
    float sharks[5];
};

@class WoMatrix;
@interface W0rld : NSObject {
    int fish;
    int sharks;
    BOOL fishmov;
    struct square **tank;
    struct square **oldTank;
    NSInteger rows;
    NSInteger columns;
    int *primes;
    BOOL debugging; 
    BOOL first;
    NSPoint origin;
    NSPoint clicked;
    NSPointArray neighbors[maxRadius];
    int size[maxRadius];
    NSPointArray seen;
}

@property BOOL paused;
@property int sharks;
@property int fish;
@property NSInteger rows;
@property NSInteger columns;

- (void)tare;
- (void)printcells;
- (void)reset;
- (NSPointArray)neighbors: (NSPoint)coord distance: (int)dist;
- (id)init;
- (float)valueOfCoordRow:(int)row column:(int)column;
- (void)mouseClickRow:(int)row Column:(int)column;
- (void)update;

@end
