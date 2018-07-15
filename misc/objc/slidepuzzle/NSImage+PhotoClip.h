#define _NATIVE_OBJC_EXCEPTIONS 1

#import <AppKit/AppKit.h>

@interface NSImage (PhotoClip)

- (NSImage *) imageFromRect: (NSRect) rect;

@end
