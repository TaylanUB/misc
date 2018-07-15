#import "NSImage+PhotoClip.h"

@implementation NSImage (PhotoClip)

- (NSImage *) imageFromRect: (NSRect) rect
{
  NSAffineTransform * xform = [NSAffineTransform transform];

  // translate reference frame to map rectangle 'rect' into first quadrant
  [xform translateXBy: -rect.origin.x
                  yBy: -rect.origin.y];

  NSSize canvas_size = [xform transformSize: rect.size];

  NSImage * canvas = [[NSImage alloc] initWithSize: canvas_size];
  [canvas lockFocus];

  [xform concat];

  // Get NSImageRep of image
  NSImageRep * rep = [self bestRepresentationForDevice: nil];

  [rep drawAtPoint: NSZeroPoint];

  [canvas unlockFocus];
  return [canvas autorelease];
}

@end
