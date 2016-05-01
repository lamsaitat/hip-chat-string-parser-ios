//
//  HCMessage.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCMessage.h"

@implementation HCMessage

- (instancetype)initWithDictionary:(NSDictionary *)sourceDictionary {
    self = [super init];
    
    if (self) {
    }
    
    return self;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    return [NSDictionary dictionaryWithDictionary:dict];  // Lock the dictionary to be immutable.
}

@end
