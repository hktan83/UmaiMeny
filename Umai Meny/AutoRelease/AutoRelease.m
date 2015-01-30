#import <Foundation/Foundation.h>
#import "Foo.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	Foo * myFoo = [[[Foo alloc] init] autorelease];

	[[myFoo giveMeABar] sayHello];
    [pool drain];
    return 0;
}
