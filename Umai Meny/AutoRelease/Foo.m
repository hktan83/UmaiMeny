//
//  Foo.m
//  AutoRelease
//
//  Created by Caleb Tan on 26/7/11.
//  Copyright 2011 Lucky Curtain Design. All rights reserved.
//

#import "Foo.h"

@implementation Foo
- (Bar *) giveMeABar {
	Bar * tempBar = [[[Bar alloc] init] autorelease];
	return tempBar;
}
@end
