//
//  HCParser.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#ifndef HCParser_h
#define HCParser_h

@protocol HCParser <NSObject>

/**
 * Detects all user mention of @XXXX pattern from a given string.
 */
- (NSArray<NSString *> *)mentionsFromString:(NSString *)sourceString;

/**
 * Detects all emoticons of (XXX) pattern from a given string.
 */
- (NSArray<NSString *> *)emoticonsFromString:(NSString *)sourceString;

/**
 * Detects all urls contained from a given string.
 */
- (NSArray<NSString *> *)urlLinksFromString:(NSString *)sourceString;

/** Unique set of mentions while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueMentionsFromString:(NSString *)sourceString;

/** Unique set of emoticons while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueEmoticonsFromString:(NSString *)sourceString;

/** Unique set of urls while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueUrlLinksFromString:(NSString *)sourceString;

@optional

- (NSURLSessionDataTask *)pageTitleForURL:(NSURL *)url completionBlock:(nullable void(^)(NSString * __nullable, NSError * __nullable))completionBlock;

@end


#endif /* HCParser_h */
