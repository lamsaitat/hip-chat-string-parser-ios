//
//  HCStubStringParser.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCStubStringParser.h"

@implementation HCStubStringParser

- (NSArray<NSString *> *)mentionsFromString:(NSString *)sourceString {
    // Guaranteed to fail any tests. except if you supply an empty string.
    return @[];
}

- (NSArray<NSString *> *)emoticonsFromString:(NSString *)sourceString {
    // Guaranteed to fail any tests. except if you supply an empty string.
    return @[];
}

- (NSArray<NSString *> *)urlLinksFromString:(NSString *)sourceString {
    // Guaranteed to fail any tests. except if you supply an empty string.
    return @[];
}

/** Unique set of mentions while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueMentionsFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSet];
}

/** Unique set of emoticons while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueEmoticonsFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSet];
}

/** Unique set of urls while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueUrlLinksFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSet];
}

@end
