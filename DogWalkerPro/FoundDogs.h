//
//  FoundDogs.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 10/09/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>
@interface FoundDogs : NSObject

@property (nonatomic, copy) NSString * objectId;
@property (nonatomic, copy) NSString * contactNumber;
@property (nonatomic, copy) NSString * descriptions;
@property (nonatomic, copy) NSDate * dateTime;
@property (atomic, readwrite) BOOL * found;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * petName;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSData * photo;
@property (nonatomic, copy) NSDate * createdAt;
@property (nonatomic, copy) NSDate * updatedAt;
@property (nonatomic, copy) NSNumber * syncStatus;


@end
