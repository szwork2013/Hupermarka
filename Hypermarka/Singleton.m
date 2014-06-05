//
//  Singleton.m
//  test4
//
//  Created by Bogdan Redkin on 12.03.14.
//  Copyright (c) 2014 mifors. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton


static Singleton* _sharedMySingleton = nil;

+(Singleton*)sharedMySingleton
{
    @synchronized([Singleton class])
    {
        if (!_sharedMySingleton)
            [[self alloc] init];
        
        return _sharedMySingleton;
    }
    
    return nil;
}

+(id)alloc
{
    @synchronized([Singleton class])
    {
        NSAssert(_sharedMySingleton == nil,
                 @"Attempted to allocate a second instance of a singleton.");
        _sharedMySingleton = [super alloc];
        return _sharedMySingleton;
    }
    
    return nil;
}

-(id)init {
    self = [super init];
    if (self != nil) {
        // initialize stuff here
    }
    
    return self;
}

-(void)test {
    
}
@end
