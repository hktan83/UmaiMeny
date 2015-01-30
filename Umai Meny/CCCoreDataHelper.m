//
//  CCCoreDataHelper.m
//  Umai Meny
//
//  Created by Caleb on 23/09/14.
//  Copyright (c) 2014 Caleb Tan. All rights reserved.
//

#import "CCCoreDataHelper.h"

@implementation CCCoreDataHelper


// Accessing our NSManagedObjectContext instance from the App Delegate the same way. Having this class method will save us from having to retype the code to access this property over and over.
+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    // Introspection to check if our app delegate implements the method mangedObjectContext
    // confirming variable delegate is responding to selector mangedObjectContext
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
