#define _NATIVE_OBJC_EXCEPTIONS 1

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

#import "Piece.h"

@interface Puzzle : NSViewController <PieceDelegate>
{
@private
    NSView *containerView;
    NSSize pieceSize;
    NSMutableArray *pieces;
    NSPoint emptyCoords;
}

- (id) initWithFrame:(NSRect)frame horizSlots:(NSUInteger)m vertSlots:(NSUInteger)n image:(NSImage *)image;

- (void) shuffle;

@end
