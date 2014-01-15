//
//  w0rld.m
//  wat0r
//
//  Created by Nicholas Colclasure on 10/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "W0rld.h"
#import <mach/mach_time.h>
#import <math.h>


@implementation W0rld

//              Debugging tools
// Depricated!!! They do not work!
- (void)tare {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            if (tank[i][j].numfish) {
                origin.x = i;
                origin.y = j;
                tank[i][j].numsharks = 1;
            }
        }
    }
}

- (void)printcells {
    printf("\n{");
    int x, y;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            if (tank[i][j].fish) { 
                x = i - origin.x;
                y = j - origin.y;
                printf("{%d, %d}, ", x, y);
            }
        }
    }
    printf("}\n");
}

@synthesize paused;
@synthesize sharks;
@synthesize fish;
@synthesize rows;
@synthesize columns;

- (id)init {
    self = [super init];
    rows = 100;
    fishmov = NO;
    columns = 100;
    debugging = NO;
    paused = YES;
    first = YES;
    clicked.x = 0;
    clicked.y = 0;
    tank = calloc(rows, sizeof(struct square *));
    oldTank = calloc(rows, sizeof(struct square *));
    NSPoint one[4] = {{-1, 0}, {0, -1}, {0, 1}, {1, 0}};    // hard coded radii for sight and movement.
    NSPoint two[20] = {
        {1, 0}, {0, 1}, {0, -1}, {-1, 0}, {2, 0}, 
        {1, 1}, {1, -1}, {0, 2}, {0, -2}, {-1, 1}, 
        {-1, -1}, {-2, 0}, {2, 1}, {2, -1}, {1, 2}, 
        {1, -2}, {-1, 2}, {-1, -2}, {-2, 1}, {-2, -1}};
    NSPoint three[36] = {
        {1, 0}, {0, 1}, {0, -1}, {-1, 0}, {2, 0}, 
        {1, 1}, {1, -1}, {0, 2}, {0, -2}, {-1, 1}, 
        {-1, -1}, {-2, 0}, {3, 0}, {2, 1}, {2, -1}, 
        {1, 2}, {1, -2}, {0, 3}, {0, -3}, {-1, 2}, 
        {-1, -2}, {-2, 1}, {-2, -1}, {-3, 0}, {3, 1}, 
        {3, -1}, {2, 2}, {2, -2}, {1, 3}, {1, -3}, 
        {-1, 3}, {-1, -3}, {-2, 2}, {-2, -2}, {-3, 1}, {-3, -1}};
    NSPoint four[68] = {
        {1, 0}, {0, 1}, {0, -1}, {-1, 0}, {2, 0}, 
        {1, 1}, {1, -1}, {0, 2}, {0, -2}, {-1, 1}, 
        {-1, -1}, {-2, 0}, {3, 0}, {2, 1}, {2, -1}, 
        {1, 2}, {1, -2}, {0, 3}, {0, -3}, {-1, 2}, 
        {-1, -2}, {-2, 1}, {-2, -1}, {-3, 0}, {4, 0}, 
        {3, 1}, {3, -1}, {2, 2}, {2, -2}, {1, 3}, {1, -3}, 
        {0, 4}, {0, -4}, {-1, 3}, {-1, -3}, {-2, 2}, 
        {-2, -2}, {-3, 1}, {-3, -1}, {-4, 0}, {4, 1}, 
        {4, -1}, {3, 2}, {3, -2}, {2, 3}, {2, -3}, 
        {1, 4}, {1, -4}, {-1, 4}, {-1, -4}, {-2, 3}, 
        {-2, -3}, {-3, 2}, {-3, -2}, {-4, 1}, {-4, -1}, 
        {4, 2}, {4, -2}, {3, 3}, {3, -3}, {2, 4}, {2, -4}, 
        {-2, 4}, {-2, -4}, {-3, 3}, {-3, -3}, {-4, 2}, {-4, -2}};
    NSPoint five[88]  = {
        {1, 0}, {0, 1}, {0, -1}, {-1, 0}, {2, 0}, 
        {1, 1}, {1, -1}, {0, 2}, {0, -2}, {-1, 1}, 
        {-1, -1}, {-2, 0}, {3, 0}, {2, 1}, {2, -1}, 
        {1, 2}, {1, -2}, {0, 3}, {0, -3}, {-1, 2}, 
        {-1, -2}, {-2, 1}, {-2, -1}, {-3, 0}, 
        {4, 0}, {3, 1}, {3, -1}, {2, 2}, {2, -2}, 
        {1, 3}, {1, -3}, {0, 4}, {0, -4}, {-1, 3}, 
        {-1, -3}, {-2, 2}, {-2, -2}, {-3, 1}, 
        {-3, -1}, {-4, 0}, {5, 0}, {4, 1}, {4, -1}, 
        {3, 2}, {3, -2}, {2, 3}, {2, -3}, {1, 4}, 
        {1, -4}, {0, 5}, {0, -5}, {-1, 4}, {-1, -4}, 
        {-2, 3}, {-2, -3}, {-3, 2}, {-3, -2}, {-4, 1}, 
        {-4, -1}, {-5, 0}, {5, 1}, {5, -1}, {4, 2}, 
        {4, -2}, {3, 3}, {3, -3}, {2, 4}, {2, -4}, 
        {1, 5}, {1, -5}, {-1, 5}, {-1, -5}, {-2, 4}, 
        {-2, -4}, {-3, 3}, {-3, -3}, {-4, 2}, {-4, -2}, 
        {-5, 1}, {-5, -1}, {4, 3}, {4, -3}, {3, 4}, 
        {3, -4}, {-3, 4}, {-3, -4}, {-4, 3}, {-4, -3}};
    size[0] = 4;    // stored sizes of each of the predefined sight radii.
    size[1] = 20;
    size[2] = 36;
    size[3] = 68;
    size[4] = 88;
    neighbors[0] = calloc(1, sizeof(one));
    neighbors[1] = calloc(1, sizeof(two));
    neighbors[2] = calloc(1, sizeof(three));
    neighbors[3] = calloc(1, sizeof(four));
    neighbors[4] = calloc(1, sizeof(five));
    memcpy(neighbors[0], one, sizeof(one));
    memcpy(neighbors[1], two, sizeof(two));
    memcpy(neighbors[2], three, sizeof(three));
    memcpy(neighbors[3], four, sizeof(four));
    memcpy(neighbors[4], five, sizeof(five));
    for (int i = 0; i < rows; i++) {
        tank[i] = calloc(columns, sizeof(struct square));
        oldTank[i] = calloc(columns, sizeof(struct square));
    }
    int rndseed = mach_absolute_time();
    srandom(rndseed);
    for (int i = 0; i < fish; i++) {
        int x = (random() % rows);
        int y = (random() % columns);
        tank[x][y].numfish = 1;
        tank[x][y].fish[0] = 1;
    }
    rndseed = mach_absolute_time();
    srandom(rndseed);
    for (int i = 0; i < sharks; i++) {
        int x = (random() % rows);
        int y = (random() % columns);
        tank[x][y].numsharks = 1;
        tank[x][y].sharks[0] = 5;
    }   
    return self;
}

- (void)reset {
    tank = calloc(rows, sizeof(struct square *));
    oldTank = calloc(rows, sizeof(struct square *));
    for (int i = 0; i < rows; i++) {
        tank[i] = calloc(columns, sizeof(struct square));
        oldTank[i] = calloc(columns, sizeof(struct square));
    }    
    for (int i = 0; i < rows; i++)
        memset(tank[i], 0, sizeof(struct square) * columns);
    int rndseed = mach_absolute_time();
    srandom(rndseed);
    for (int i = 0; i < fish; i++) {
        int x = (random() % rows);
        int y = (random() % columns);
        tank[x][y].numfish = 1;
        tank[x][y].fish[0] = 1;
    }
    rndseed = mach_absolute_time();
    srandom(rndseed);
    for (int i = 0; i < sharks; i++) {
        int x = (random() % rows);
        int y = (random() % columns);
        tank[x][y].numsharks = 1;
        tank[x][y].sharks[0] = 5;
    }   
    [(id)[NSApp delegate] updateDisplay];
}


- (void)update {
    fish = 0;
    sharks = 0;
    int rndseed = mach_absolute_time();
    srandom(rndseed);
//    for (int l = 0; l < size[5]; l++) {
//        tank[(int)seen[l].x][(int)seen[l].y].seen = NO;
//        tank[(int)seen[l].x][(int)seen[l].y].targeted = NO;
//    }
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            oldTank[i][j] = tank[i][j];
        }
    }
//    fishmov = !fishmov;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < columns; j++) {
            if (oldTank[i][j].numfish >= 1 && oldTank[i][j].numsharks >= 1) {
                float food = 0.0;
                for (int k = 0; k < oldTank[i][j].numfish; k++) {
                    food += oldTank[i][j].fish[k];
                    tank[i][j].fish[k] = 0;
                }
                tank[i][j].numfish = 0;
                if (oldTank[i][j].numsharks == 1) {
                    tank[i][j].sharks[0] += food;
                }
                else {
                    for (int k = 0; k < oldTank[i][j].numsharks; k++) {
                        tank[i][j].sharks[k] += food / oldTank[i][j].numsharks;
                    }
                }
                printf("");
            }
            if (oldTank[i][j].numsharks >= 1) {
                // problem was: all sharks in the same square had the same target
//                target = clicked;
                // Let the sharks reproduce
                for (int l = tank[i][j].numsharks - 1; l >= 0; l--) {
                    if (tank[i][j].numsharks >= 5)
                        break;
                    if (tank[i][j].sharks[l] >= 10) {
                        tank[i][j].sharks[tank[i][j].numsharks] = 5;
                        tank[i][j].sharks[l] = 5;
                        tank[i][j].numsharks += 1;
                    }
                }
                // Move each of the sharks in the square
                for (int l = tank[i][j].numsharks - 1; l >= 0; l--) {
                    for (int k = 0; k <= 4; k++) {
                        NSPoint coord = {i, j};
                        NSPoint target = {-1, -1};
                        NSPointArray posDir = [self neighbors: coord distance:0];
                        NSPointArray sight = [self neighbors:coord distance:3];
                        for (int l = 0; l < size[3]; l++) {
                            if (tank[(int)sight[l].x][(int)sight[l].y].numfish > 0) {
                                target.x = sight[l].x;
                                target.y = sight[l].y;
                                break;
                            }
                        }
                        free(sight);
                        int x, y;
                        if (target.x >= 0) {
                            int dir;
                            if (abs(target.x - i) > abs(target.y - j)) {
                                dir = 1;
                            } else {
                                dir = 2;
                            }
                            if (dir == 1) {
                                if (target.x > i) {
                                    x = i + 1;
                                    y = j;
                                }
                                else {
                                    x = i - 1;
                                    y = j;
                                }
                            }
                            else {
                                if (target.y > j) {
                                    y = j + 1;
                                    x = i;
                                }
                                else {
                                    y = j - 1;
                                    x = i;
                                }
                            }
                        }
                        else {
                            int dir = (random() % 4);
                            x = (int)posDir[dir].x;
                            y = (int)posDir[dir].y;
                            free(posDir);
                        }
                        if (tank[x][y].numsharks < 5) {
                            tank[x][y].sharks[tank[x][y].numsharks] += tank[i][j].sharks[l] - .25;
                            tank[i][j].sharks[l] -= tank[i][j].sharks[l];
                            tank[i][j].numsharks--;
                            tank[x][y].numsharks++;
//                            NSPoint next = {x, y};
//                            seen = [self neighbors:next distance:5];
//                            for (int l = 0; l < size[4]; l++) {
//                                tank[(int)seen[l].x][(int)seen[l].y].seen = YES;
//                            }
//                            for (int l = 0; l < size[4]; l++) {
//                                if (oldTank[(int)seen[l].x][(int)seen[l].y].numfish > 0) {
//                                    tank[(int)seen[l].x][(int)seen[l].y].targeted = YES;
//                                    break;
//                                }
//                            }                            
                            if (tank[x][y].sharks[tank[x][y].numsharks - 1] < 1) {
                                tank[x][y].sharks[tank[x][y].numsharks] = 0;
                                tank[x][y].numsharks--;
                            }
                            break;
                        }
                    }
                }
            }
//            else if (fishmov) {
            else if (YES) {
                if (oldTank[i][j].numfish >= 1) {
                    NSAssert1(tank[i][j].numfish <= 10, @"Too many fish! (%d)", tank[i][j].numfish);
                    NSPoint coord = {i, j};
                    NSPointArray posDir = [self neighbors: coord distance:0];
                    for (int l = 0; l < tank[i][j].numfish; l++) {
                        if (tank[i][j].numfish >= 10)
                            break;
                        if (oldTank[i][j].fish[l] >= 2) {
                            tank[i][j].fish[tank[i][j].numfish] = 1;
                            tank[i][j].fish[l] = 1;
                            tank[i][j].numfish++;
                        }
                    }
                    for (int l = 0; l < tank[i][j].numfish; l++) {
                        for (int k = 0; k <= 4; k++) {
                            int x, y;
                            int dir = (random() % 4);
                            x = (int)posDir[dir].x;
                            y = (int)posDir[dir].y;
                            if (tank[x][y].numfish < 10) {
                                tank[x][y].fish[tank[x][y].numfish] += tank[i][j].fish[l] + .25;
                                tank[i][j].fish[l] = 0;
                                tank[i][j].numfish--;
                                tank[x][y].numfish++;
                                break;
                            }
                        }
                    }
                    free(posDir);
                }
            }
            fish += oldTank[i][j].numfish;
            sharks += oldTank[i][j].numsharks;
        }
    }
  //  if (first) {
//        for (int i = 0; i < rows; i++) {
//            for (int j = 0; j < columns; j++) {
//                NSAssert1(abs(tank[i][j].numfish) <= 1, @"Too many fish! (%d)", tank[i][j].numfish);
//                NSAssert1(abs(tank[i][j].numsharks) <= 1, @"Too many sharks! (%d)", tank[i][j].numsharks);
//            }
//        }
//        first = NO;
//    }
    [[NSApp delegate] updateDisplay];
    if (!paused)
        [self performSelector:@selector(update) withObject:nil afterDelay:0.0];
}

- (float)valueOfCoordRow:(int)row column:(int)column {
//    if (tank[row][column].targeted)
//        return 0.2;
//    if (tank[row][column].seen && !tank[row][column].numfish)
//        return 0.1;
    if (tank[row][column].numsharks)
        return -tank[row][column].numsharks;
    else
        return tank[row][column].numfish;
    
//    NSAssert1(tank[row][column].numfish <= 10, @"Too many fish! (%d)", tank[row][column].numfish);

}

- (NSPointArray)neighbors: (NSPoint)coord distance: (int)dist {
    NSPointArray offset = neighbors[dist];
    NSPointArray near = calloc(size[dist], sizeof(NSPoint));
//    int dir = random() % 10;
    int distances[10] = {0};
    int i, j = 0;
    for (i = 0; i <= dist; i++) {
        while (j < size[dist]) {
            if ((abs((int)offset[j].x) + abs((int)offset[j].y)) == i + 1) {
                distances[i]++;
                j++;
            }
            else
                break;
        }
    }
    int **randnear = calloc(i + 1, sizeof(int *));
    for (j = 0; j <= dist; j++)
        randnear[j] = calloc(distances[j], sizeof(int));
    int position = 0;
    for (i = 0; i <= dist; i++) {
        if (i - 1 >= 0)
            position += distances[i - 1];
        for (j = 0; j < distances[i]; j++) {
            randnear[i][j] = j + position;
        }
    }
    for (i = 0; i <= dist; i++) {
        for (int n = distances[i]; n > 1; n--) {
            int rnd = random() % n;
            int i0 = randnear[i][n - 1];
            int i1 = randnear[i][rnd];
            randnear[i][n - 1] = i1;
            randnear[i][rnd] = i0;
        }
    }
//    for (i = 0; i <= dist; i++) {
//        printf("randnear[%d]: ", i);
//        for (j = 0; j < distances[i]; j++) {
//            printf("%d, ", randnear[i][j]);
//        }
//        printf("\n");
//    }
//    printf("\n");
//    printf("%d\n", dist);
//    for (i = 0; i <= dist; i++) {
//        printf("%d, ", distances[i]);
//    }
//    printf("\n");
    int d = 0;
    for (i = 0; i <= dist; i++) {
        for (j = 0; j < distances[i]; j++) {
            int x, y;
            if ((int)offset[randnear[i][j]].x > 0)
                x = ((int)coord.x + (int)offset[randnear[i][j]].x) % rows;
            else
                x = ((int)coord.x + (rows + (int)offset[randnear[i][j]].x)) % rows;
            if ((int)offset[randnear[i][j]].y > 0)
                y = ((int)coord.y + (int)offset[randnear[i][j]].y) % columns;
            else
                y = ((int)coord.y + (columns + (int)offset[randnear[i][j]].y)) % columns;
//            printf("{%d, %d,}, %d/%d, dist=%d\n\n", x, y, d, size[dist], dist);
            near[d].x = x;
            near[d].y = y;
//            printf("{%d, %d}\n", x, y);
            d++;
        }
    }
    for (j = 0; j <= dist; j++)
        free(randnear[j]);
    free(randnear);
//    printf("near[0]: ");
//    for (i = 0; i < size[dist]; i++) {
//        printf("{%d, %d}, ", (int)near[i].x, (int)near[i].y);
//    }
//    printf("\n");
    
//    NSAssert1(tank[(int)coord.x][(int)coord.y].numfish <= 10, @"Too many fish! (%d)", tank[(int)coord.x][(int)coord.y].numfish);
    return near;
}   

- (void)mouseClickRow:(int)row Column:(int)column {
    if (debugging) {
        int dist = 5;
        for (int i = 0; i < rows; i++)
            memset(tank[i], 0, sizeof(int) * columns);
        NSPoint coord = {row, column};
        NSPointArray near = [self neighbors:coord distance:dist];
        for (int i = 0; i < size[dist - 1]; i++) {
            tank[(int)near[i].x][(int)near[i].y].numfish = 1;
        }
    }
    else {
        if (!tank[row][column].numfish) {
            tank[row][column].numfish = 1;
            tank[row][column].fish[0] = 1;
        }
        else {
            tank[row][column].numfish = 0;
        }
//        clicked.x = row;
//        clicked.y = column;
    }
}

@end
