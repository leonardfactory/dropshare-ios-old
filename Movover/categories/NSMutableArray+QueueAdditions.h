//
//  NSMutableArray+QueueAdditions.h
//  Movover
//
//  Created by esromneb
//  https://github.com/esromneb/ios-queue-object/
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)

-(id) dequeue;
-(void) enqueue:(id)obj;
-(id) peek:(int)index;
-(id) peekHead;
-(id) peekTail;
-(BOOL) empty;

@end
