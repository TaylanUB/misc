#define _NATIVE_OBJC_EXCEPTIONS 1

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

#import "Puzzle.h"

@interface SlidingPuzzleAppDelegate : NSObject
{
@private
    NSWindow *mainWindow;
    Puzzle *puzzle;
}

@end
