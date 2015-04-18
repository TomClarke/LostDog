//
//  SDAFParseAPIClient.h
//  DogWalkerPro
//
//  Created by Thomas Clarke on 28/07/2013.
//  Copyright (c) 2013 Thomas Clarke. All rights reserved.
//

#import "AFHTTPClient.h"

@interface SDAFParseAPIClient : AFHTTPClient

+ (SDAFParseAPIClient *)sharedClient;

- (NSMutableURLRequest *)GETRequestForClass:(NSString *)className parameters:(NSDictionary *)parameters;
- (NSMutableURLRequest *)GETRequestForAllRecordsOfClass:(NSString *)className updatedAfterDate:(NSDate *)updatedDate;

@end
