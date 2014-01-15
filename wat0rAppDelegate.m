//
//  wat0rAppDelegate.m
//  wat0r
//
//  Created by Nicholas Colclasure on 9/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "wat0rAppDelegate.h"
#import "W0rld.h"
#import "w0Cell.h"
#import "Grid.h"

@implementation wat0rAppDelegate

@synthesize window;

//              Debugging tools
- (IBAction)tare: (id)sender;
{
    [world tare];
}   

- (IBAction)printcells: (id)sender;
{
    [world printcells];
}

- (IBAction)Start: (id)sender;
{
    world.paused = NO;
    [world update];
}

- (IBAction)Apply: (id)sender;
{
    display.cellSize = [[options cellAtIndex:4] floatValue];
    display.rows = [[options cellAtIndex:3] intValue];
    display.columns = [[options cellAtIndex:2] intValue];
    [display setNeedsDisplay:YES];    
}

- (IBAction)Pause: (id)sender;
{
    world.paused = YES;
}

- (IBAction)Restart: (id)sender;
{
     world.fish = [[options cellAtIndex:0] intValue];
    world.sharks = [[options cellAtIndex:1] intValue];
    world.rows = [[options cellAtIndex:3] intValue];
    world.columns = [[options cellAtIndex:2] intValue];
    [world reset];
}

//- (Class)dataSetClass;
//{
//    return [GRLineDataSet class];
//}
    

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
{
//    fishdataset = [[[self dataSetClass] alloc] initWithOwnerChart:_chartView];
//    [_chartView addDataSet: fishdataset loadData: NO];
//    sharkdataset = [[[self dataSetClass] alloc] initWithOwnerChart:_chartView];
//    [_chartView addDataSet:sharkdataset loadData:NO];
//    fishstats = [[NSMutableArray alloc] init];
//    sharkstats = [[NSMutableArray alloc] init];
    world = [[W0rld alloc] init];
    [self Apply:self];
}


- (void)updateDisplay;
{
    [fishDisp setIntValue:world.fish];
    [sharkDisp setIntValue:world.sharks];
//    [fishstats addObject:[NSNumber numberWithInt:world.fish]];
//    [sharkstats addObject:[NSNumber numberWithInt:world.sharks]];
//    [_chartView setNeedsToReloadData:YES];
//    [_chartView setNeedsDisplay:YES];
    [display setNeedsDisplay:YES];
}
     
//- (void)click: (id)sender;
//{
//    [world mouseClickRow:[display clickedRow] Column:[display clickedColumn]];
//    [display reloadData];
//}

- (NSColor *)grid:(Grid *)aGrid colorOfx:(int)x y:(int)y;
{
    int state = [world valueOfCoordRow:y column:x];
    if (state == 0.2) {
        return [NSColor redColor];
    }
    else if (state == 0.1) {
        return [NSColor whiteColor];
    }
	else if (!state) {
        return [NSColor blueColor];
	}
	else if (state > 0) {
		float green = .3 + (state / 10);
        return [NSColor colorWithCalibratedRed:0.0 
                                         green:green
                                          blue:1 - green 
                                         alpha:1.0];

	}
	else if (state < 0) {
		state = -state;
		float red = .3 + (state / 5);
        return [NSColor colorWithCalibratedRed:red
                                         green:0.0
                                          blue:1 - red
                                         alpha:1.0];
	}
    return [NSColor orangeColor];

}

//- (NSInteger) chart: (GRChartView *) chartView numberOfElementsForDataSet: (GRDataSet *) dataSet;
//{
//    if (dataSet == sharkdataset) 
//        return [sharkstats count];
//    else
//        return [fishstats count];
//}
//
//- (double) chart: (GRChartView *) chartView yValueForDataSet: (GRDataSet *) dataSet element: (NSInteger) element;
//{
//    if (dataSet == sharkdataset) 
//        return [[sharkstats objectAtIndex:element] intValue];
//    else
//        return [[fishstats objectAtIndex:element] intValue];
//    printf("yValueForDataSet called");
//}
//
//- (NSColor *) chart: (GRChartView *) chartView colorForDataSet: (GRDataSet *) dataSet element: (NSInteger) element;
//{
//    if (dataSet == sharkdataset)
//        return [NSColor redColor];
//    else 
//        return [NSColor greenColor];
//}



- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication;
{
    return YES;
}


@end
