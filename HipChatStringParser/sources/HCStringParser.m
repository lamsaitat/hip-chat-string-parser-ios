//
//  HCStringParser.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCStringParser.h"
#import "HCConstants.h"

@implementation HCStringParser

/** This method does not guarantee the elements are unique.
 */
- (NSArray<NSString *> *)mentionsFromString:(NSString *)sourceString {
    NSError *regexError = nil;
    NSMutableArray *mentions = [NSMutableArray array];
    
    // Make sure the string is parseable first.
    if (sourceString && sourceString.length > 0) {
        // A mention begins with '@' and ends with non-word char.
        // In otherwords, it means a mention is anything conforming to '@' followed
        // by 1 or more 'word' char(s).
        NSString *pattern = @"@[\\w]+";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&regexError];
        if (regex != nil && regexError == nil) {
            NSArray *results = [regex matchesInString:sourceString options:0 range:NSMakeRange(0, sourceString.length)];
            
            for (NSTextCheckingResult *result in results) {
                NSRange range = result.range;
                range.location += 1;  // We know that the first character is '@', so we can safely strip it out by shifting the starting point 1 forward.
                range.length -= 1;  // Because we shifted the starting point by 1, so we need to reduce the length by 1.
                NSString *mention = [sourceString substringWithRange:range];
                [mentions addObject:mention];
            }
        } else {
            NSLog(@"Failed to initialise regex with error: %@", regexError.localizedDescription);
        }
    }
    
    return mentions;
}

- (NSArray<NSString *> *)emoticonsFromString:(NSString *)sourceString {
    NSError *regexError = nil;
    NSMutableArray *mentions = [NSMutableArray array];
    
    // Make sure the string is parseable first.
    if (sourceString && sourceString.length > 0) {
        // Emoticons - For this exercise, you only need to consider 'custom'
        // emoticons which are alphanumeric strings, no longer than 15
        // characters, contained in parenthesis. You can assume that anything
        // matching this format is an emoticon.
        // (https://www.hipchat.com/emoticons)
        NSString *pattern = @"\\([a-zA-Z0-9]{1,15}\\)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&regexError];
        if (regex != nil && regexError == nil) {
            NSArray *results = [regex matchesInString:sourceString options:0 range:NSMakeRange(0, sourceString.length)];
            
            for (NSTextCheckingResult *result in results) {
                NSRange range = result.range;
                // We know that an emoticon must be surrounded by (), so we need
                // to strip away the first char, and the last.
                // i.e. Shift forward the starting range by 1, and less 2 chars
                // in length.
                range.location += 1;
                range.length -= 2;
                NSString *mention = [sourceString substringWithRange:range];
                [mentions addObject:mention];
            }
        } else {
            NSLog(@"Failed to initialise regex with error: %@", regexError.localizedDescription);
        }
    }
    
    return mentions;
}

- (NSArray<NSString *> *)urlLinksFromString:(NSString *)sourceString {
    NSMutableArray *links = [NSMutableArray array];
    
    if (sourceString) {
        NSError *detectorError = nil;
        NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink error:&detectorError];

        if (detector != nil && detectorError == nil) {
            NSArray *results = [detector matchesInString:sourceString options:NSMatchingReportProgress range:NSMakeRange(0, sourceString.length)];
            
            for (NSTextCheckingResult *result in results) {
                if (result.URL != nil) {
                    [links addObject:result.URL.absoluteString];
                }
            }
        } else {
            NSLog(@"Failed to initialise a data detector with error: %@", [detectorError localizedDescription]);
        }
    }
    
    return links;
}

/** Unique set of mentions while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueMentionsFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSetWithArray:[self mentionsFromString:sourceString]];
}

/** Unique set of emoticons while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueEmoticonsFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSetWithArray:[self emoticonsFromString:sourceString]];
}

/** Unique set of urls while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueUrlLinksFromString:(NSString *)sourceString {
    return [NSOrderedSet orderedSetWithArray:[self urlLinksFromString:sourceString]];
}

- (NSDictionary *)dictionaryFromString:(NSString *)sourceString {
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    
    // Parse the mentions first.
    NSArray *mentions = [self mentionsFromString:sourceString];
    if (mentions && mentions.count > 0) {
        results[kHCParserDictionaryMentionsKey] = mentions;
    }
    
    NSArray *emoticons = [self emoticonsFromString:sourceString];
    if (emoticons && emoticons.count > 0) {
        results[kHCParserDictionaryEmoticonsKey] = emoticons;
    }
    
    NSArray *links = [self urlLinksFromString:sourceString];
    if (links && links.count > 0) {
        NSMutableArray *linkDicts = [NSMutableArray array];
        for (NSString *url in links) {
            // Allow for post-modifications to the dictionary.
            NSMutableDictionary *linkDict = [@{
                                               kHCParserDictionaryUrlKey: url
                                               } mutableCopy];
            [linkDicts addObject:linkDict];
        }
        results[kHCParserDictionaryLinksKey] = linkDicts;
    }
    
    return results;
}

@end
