//
//  w0Cell.m
//  wat0r
//
//  Created by Nicholas Colclasure on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "w0Cell.h"


@implementation w0Cell


- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	float state = [self floatValue];
    if (state == 0.2) {
        [self setBackgroundColor:[NSColor redColor]];
        [self setTextColor:[NSColor redColor]];
    }
    else if (state == 0.1) {
        [self setBackgroundColor:[NSColor whiteColor]];
        [self setTextColor:[NSColor whiteColor]];
    }
	else if (!state) {
		[self setBackgroundColor:[NSColor blueColor]];
		[self setTextColor:[NSColor blueColor]];
	}
	else if (state > 0) {
		float green = .3 + (state / 10);
		[self setBackgroundColor:[NSColor colorWithCalibratedRed:0.0 
														   green:green
															blue:1 - green 
														   alpha:1.0]];
		[self setTextColor:[NSColor colorWithCalibratedRed:0.0 
													 green:green
													  blue:1 - green
													 alpha:1.0]];
	}
	else if (state < 0) {
		state = -state;
		float red = .3 + (state / 5);
		[self setBackgroundColor:[NSColor colorWithCalibratedRed:red
														   green:0.0
															blue:1 - red
														   alpha:1.0]];
		[self setTextColor:[NSColor blackColor]];
	}
	[super drawWithFrame:cellFrame inView:controlView];
}

@end
