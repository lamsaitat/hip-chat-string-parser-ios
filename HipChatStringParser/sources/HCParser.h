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

extern NSString *kHCParserDictionaryMentionsKey;
extern NSString *kHCParserDictionaryEmoticonsKey;
extern NSString *kHCParserDictionaryLinksKey;
extern NSString *kHCParserDictionaryUrlKey;
extern NSString *kHCParserDictionaryTitleKey;

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
 * Look for urls in the dictionary and perform page title fetches on each of them,
 * while all fetches are completed, whether successful or not, gives back a 
 * dictionary via the completion block.
 * @Discussion: The dictionary returned in the completion block is not guaranteed to be the same object as the source dictionary, i.e. sourceDictionary !== finalDictionary.  The worst case scenario where all fetching has failed you will still guarantee to have the (equivalent of) source dictionary returned.
 */
- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithDictionary:(NSDictionary *)sourceDictionary completionBlock:(nullable void(^)(NSDictionary * __nonnull, NSError * __nullable))completionBlock;

- (NSURLSessionDataTask * __nullable)dictionaryFromString:(NSString * __nullable)sourceString completionBlock:(nullable void(^)(NSDictionary * __nullable, NSError * __nullable))completionBlock;

@end

#pragma clang diagnostic pop

#endif /* HCParser_h */
