#import <stdlib.h>
#import <time.h>

#import "Puzzle.h"
#import "NSImage+PhotoClip.h"

@interface Puzzle()

- (BOOL) isNeighbourToEmpty:(Piece *)piece;
- (void) swapPieceWithEmpty:(Piece *)piece;

@end


@implementation Puzzle

- (id) initWithFrame:(NSRect)frame horizSlots:(NSUInteger)m vertSlots:(NSUInteger)n image:(NSImage *)image
{
    if ( (self = [super init]) ) {

        if ( ! (m && n) )
            return nil;

        containerView = [[NSView alloc] initWithFrame:frame];
        [self setView:containerView];

        pieceSize = NSMakeSize(frame.size.width/m, frame.size.height/n);

        pieces = [[NSMutableArray alloc] init];
        for (NSUInteger i=0; i<m; ++i) {
            for (NSUInteger j=0; j<n; ++j) {
                if ( i==m-1 && j==0 )
                    continue;
                NSRect f = NSMakeRect(pieceSize.width*i, pieceSize.height*j, pieceSize.width, pieceSize.height);
                Piece *piece = [[Piece alloc] initWithFrame:f image:[image imageFromRect:f]];
                [piece setDelegate:self];
                [pieces addObject:piece];
                [containerView addSubview:piece];
                [piece release];
            }
        }

        emptyCoords = NSMakePoint(pieceSize.width*(m-1), 0);

    }

    return self;
}

- (void) pieceWasClicked:(Piece *)piece
{
    if ( [self isNeighbourToEmpty:piece] )
        [self swapPieceWithEmpty:piece];
}

- (BOOL) isNeighbourToEmpty:(Piece *)piece
{
    NSRect f = [piece frame];

    if (f.origin.x == emptyCoords.x) {

        if (f.origin.y - pieceSize.height == emptyCoords.y || f.origin.y + pieceSize.height == emptyCoords.y)
            return YES;

    } else if (f.origin.y == emptyCoords.y) {

        if (f.origin.x - pieceSize.width == emptyCoords.x || f.origin.x + pieceSize.width == emptyCoords.x)
            return YES;

    }

    return NO;
}

- (void) swapPieceWithEmpty:(Piece *)piece
{
    NSRect frame = [piece frame];

    NSPoint oldPieceCoords = frame.origin;

    frame.origin = emptyCoords;
    [piece setFrame:frame];

    emptyCoords = oldPieceCoords;

    [containerView setNeedsDisplay:YES];
}

- (void) shuffle
{
    srand(time(NULL));
    for (NSUInteger i=0; i<9999; ++i)
        [self pieceWasClicked:[pieces objectAtIndex:rand()%([pieces count]-1)]];
}

- (void) dealloc
{
    [containerView release];
    [pieces release];

    [super dealloc];
}

@end
