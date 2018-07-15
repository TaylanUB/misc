#import "Piece.h"

@implementation Piece

- (id) initWithFrame:(NSRect)frame image:(NSImage *)_image
{
  if ( ! (self = [super initWithFrame:frame]) )
    return nil;
  
  delegate = nil;
  image = [_image retain];

  return self;
}

- (void) drawRect:(NSRect)dirtyRect
{
  [image drawAtPoint:NSZeroPoint fromRect:[self bounds] operation:NSCompositeSourceOver fraction:1];
}

- (void) setDelegate:(id)_delegate
{
  [delegate release];
  delegate = [_delegate retain];
}

- (BOOL) acceptsFirstResponder
{
  return YES;
}

- (void) rightMouseUp:(NSEvent *)event
{
  [delegate pieceWasClicked:self];
}

- (void) dealloc
{
  [delegate release];
  [image release];

  [super dealloc];
}

@end
