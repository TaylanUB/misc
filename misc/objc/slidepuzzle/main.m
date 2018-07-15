#import "SlidingPuzzleAppDelegate.h"

int main(int argc, const char *argv[])
{
    NSApplication *app = [NSApplication sharedApplication];
    SlidingPuzzleAppDelegate *delegate = [[SlidingPuzzleAppDelegate alloc] init];
    [app setDelegate:delegate];
    [app run];
    [delegate release];
    return 0;
}
