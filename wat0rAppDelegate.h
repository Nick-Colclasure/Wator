//
//  wat0rAppDelegate.h
//  wat0r
//
//  Created by Nicholas Colclasure on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GRChartView.h"
#import "GRPieDataSet.h"
#import "GRXYDataSet.h"
#import "GRAreaDataSet.h"
#import "GRLineDataSet.h"
#import "GRColumnDataSet.h"
#import "GRAxes.h"


@class W0rld;
@class Grid;

@interface wat0rAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    IBOutlet NSTextField *sharkDisp;
    IBOutlet NSTextField *fishDisp;    
//    IBOutlet GRChartView *_chartView;
	IBOutlet Grid *display;
    IBOutlet NSForm *options;
	W0rld *world;
//    NSMutableArray *fishstats;
//    NSMutableArray *sharkstats;
//    GRLineDataSet *fishdataset;
//    GRLineDataSet *sharkdataset;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)tare: (id)sender;
- (IBAction)printcells: (id)sender;
- (IBAction)Start: (id)sender;
- (IBAction)Pause: (id)sender;
- (IBAction)Restart: (id)sender;
- (IBAction)Apply: (id)sender;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
//- (void)click: (id)sender;
- (NSColor *)grid:(Grid *)aGrid colorOfx:(int)x y:(int)y;
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication;
- (void)updateDisplay;


@end
