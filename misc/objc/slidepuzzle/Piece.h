#define _NATIVE_OBJC_EXCEPTIONS 1

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@protocol PieceDelegate;

@interface Piece : NSView
{
@private
  id <PieceDelegate> delegate;
  NSImage *image;
}

- (id) initWithFrame:(NSRect)frame image:(NSImage *)image;

- (void) setDelegate:(id)delegate;

@end

@protocol PieceDelegate <NSObject>

- (void) pieceWasClicked:(Piece *)piece;

@end
