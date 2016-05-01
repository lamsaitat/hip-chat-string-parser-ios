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

// Don't need to warn us about other methods not giving nullability...
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

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

- (NSURLSessionDataTask *)pageTitleForURL:(NSURL * __nonnull)url completionBlock:(nullable void(^)(NSString * __nullable, NSError * __nullable))completionBlock;


#pragma mark - HipChat combined parsers.

- (NSDictionary *)dictionaryFromString:(NSString *)sourceString;

- (NSURLSessionDataTask * __nullable)dictionaryFromString:(NSString * __nullable)sourceString completionBlock:(nullable void(^)(NSDictionary * __nullable, NSError * __nullable))completionBlock;

#pragma clang diagnostic pop

@end


#endif /* HCParser_h */
