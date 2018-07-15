#import "SlidingPuzzleAppDelegate.h"

@implementation SlidingPuzzleAppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notif
{
    NSRect rect = NSMakeRect(0, 0, 500, 500);
    mainWindow = [[NSWindow alloc] initWithContentRect:rect styleMask:0 backing:0 defer:NO];

    [mainWindow makeMainWindow];
    [mainWindow makeKeyAndOrderFront:self];

    NSImage *i = [[NSImage alloc] initWithContentsOfFile:@"/home/tub/src/misc/objc/gnustep/slidepuzzle/img.png"];
    puzzle = [[Puzzle alloc] initWithFrame:rect horizSlots:5 vertSlots:5 image:i];
    [puzzle shuffle];
    [i release];
    [[mainWindow contentView] addSubview:[puzzle view]];
}

- (void) applicationDidTerminate:(NSNotification *)notif
{
    [puzzle release];
    [mainWindow release];
}

@end
