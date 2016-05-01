//
//  HCParser.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#ifndef HCParser_h
#define HCParser_h

// Don't need to warn us about other methods not giving nullability...
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"

@class HCMessage;

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

- (NSURLSessionDataTask *)pageTitleForURL:(NSURL * __nonnull)url completionBlock:(nullable void(^)(NSString * __nullable, NSError * __nullable))completionBlock;


#pragma mark - HipChat combined parsers.

/**
 * Parses the input string and returns a dictionary containing mentions, emoticons,
 * links if any was found.
 * @Dicussion:  This method does not automatically fetch for a url's page title. In practical cases, say actually HipChat, you want to display the informations that you can immediately obtain values, whether or not you can actually get the page title from that url, can be handled separately without blocking the usage of the app.
 */
- (NSDictionary *)dictionaryFromString:(NSString *)sourceString;

/**
 * Look for urls in the message object and fetch each of the urls' page title.  When all data tasks are finished (non active), calls the completion block with a message object filled with all title.
 * @Discussion: the message object returned in the completionBlock is not guaranteed to be the same object as the sourceObject.
 */
- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithMessage:(HCMessage *)sourceMessage completionBlock:(nullable void(^)(HCMessage * __non_null, NSError * __nullable))completionBlock;

/**
 * Basically the same logic, except you pass in a source dictionary, the underlying code will instantiate a HCMessage object and instead of a HCMessage object returned in the completionBlock, it's dictionary property will be returned, which you can choose to convert it back into a HCMessage again.
 */
- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithDictionary:(NSDictionary *)sourceDictionary completionBlock:(nullable void(^)(NSDictionary * __nonnull, NSError * __nullable))completionBlock;

@end

#pragma clang diagnostic pop

#endif /* HCParser_h */
