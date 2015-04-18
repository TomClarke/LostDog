//
//  SDSyncEngine.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 31/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDAFParseAPIClient.h"
#import "AFHTTPRequestOperation.h"

@interface SDSyncEngine : NSObject

+ (SDSyncEngine *)sharedEngine;
- (void)registerNSManagedObjectClassToSync:(Class)aClass;


@property (atomic, readonly) BOOL syncInProgress;
- (void)startSync;

typedef enum {
    SDObjectSynced = 0,
    SDObjectCreated,
    SDObjectDeleted,
} SDObjectSyncStatus;



@end
