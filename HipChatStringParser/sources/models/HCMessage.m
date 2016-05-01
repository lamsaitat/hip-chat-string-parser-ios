//
//  HCMessage.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCMessage.h"
#import "HCLink.h"
#import "HCConstants.h"

@implementation HCMessage

- (instancetype)initWithDictionary:(NSDictionary *)sourceDictionary {
    self = [super init];
    
    if (self) {
        self.mentions = [NSMutableArray array];
        self.emoticons = [NSMutableArray array];
        self.links = [NSMutableArray array];
        
        if (sourceDictionary) {
            // Check every element in the array is of the correct type, if there is one object that fails the test, we reject the entire array.
            if ([sourceDictionary[kHCParserDictionaryMentionsKey] isKindOfClass:[NSArray<NSString *> class]]) {
                BOOL isArrayValid = YES;
                NSArray *mentions = sourceDictionary[kHCParserDictionaryMentionsKey];
                for (id obj in mentions) {
                    if ([obj isKindOfClass:[NSString class]] == NO) {
                        isArrayValid = NO;
                        break;
                    }
                }
                
                if (isArrayValid) {
                    [self.mentions addObjectsFromArray:mentions];
                }
            }
            
            if ([sourceDictionary[kHCParserDictionaryEmoticonsKey] isKindOfClass:[NSArray<NSString *> class]]) {
                BOOL isArrayValid = YES;
                NSArray *emoticons = sourceDictionary[kHCParserDictionaryEmoticonsKey];
                for (id obj in emoticons) {
                    if ([obj isKindOfClass:[NSString class]] == NO) {
                        isArrayValid = NO;
                        break;
                    }
                }
                
                if (isArrayValid) {
                    [self.emoticons addObjectsFromArray:emoticons];
                }
            }
            
            if ([sourceDictionary[kHCParserDictionaryLinksKey] isKindOfClass:[NSArray<NSDictionary *> class]]) {
                for (NSDictionary *linkDict in sourceDictionary[kHCParserDictionaryLinksKey]) {
                    HCLink *link = [[HCLink alloc] initWithDictionary:linkDict];
                    [self.links addObject:link];
                }
            }
        }
    }
    
    return self;
}

- (NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.mentions.count > 0) {
        dict[kHCParserDictionaryMentionsKey] = [NSArray arrayWithArray:self.mentions];
    }
    if (self.emoticons.count > 0) {
        dict[kHCParserDictionaryEmoticonsKey] = [NSArray arrayWithArray:self.emoticons];
    }
    if (self.links.count > 0) {
        NSMutableArray *linkDicts = [NSMutableArray arrayWithCapacity:self.links.count];  // We know exactly how many objects there are to process, so we can pre-allocate that much memory.
        for (HCLink *link in self.links) {
            [linkDicts addObject:[link dictionary]];
        }
        dict[kHCParserDictionaryLinksKey] = linkDicts;
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];  // Lock the dictionary to be immutable.
}

@end
