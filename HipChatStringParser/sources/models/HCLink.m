//
//  HCLink.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCLink.h"
#import "HCConstants.h"

@implementation HCLink

- (instancetype)initWithDictionary:(NSDictionary *)sourceDictionary {
    self = [super init];
    
    if (self) {
        if (sourceDictionary) {
            if ([sourceDictionary[kHCParserDictionaryUrlKey] isKindOfClass:[NSURL class]]) {
                self.url = sourceDictionary[kHCParserDictionaryUrlKey];
            } else if ([sourceDictionary[kHCParserDictionaryUrlKey] isKindOfClass:[NSString class]]) {
                self.url = [NSURL URLWithString:sourceDictionary[kHCParserDictionaryUrlKey]];
            }
            
            if ([sourceDictionary[kHCParserDictionaryTitleKey] isKindOfClass:[NSString class]]) {
                self.title = sourceDictionary[kHCParserDictionaryTitleKey];
            }
        }
    }
    
    return self;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.url) {
        dict[kHCParserDictionaryUrlKey] = self.url.absoluteString;
    }
    if (self.title) {
        dict[kHCParserDictionaryTitleKey] = self.title;
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];  // Lock the dictionary to be immutable.
}

- (NSString *)jsonString {
    return nil;
}

@end
