//
//  HCStringParser.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCStringParser.h"

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
    // TODO: Implement the method.
    return @[];
}

- (NSArray<NSString *> *)urlLinksFromString:(NSString *)sourceString {
    // TODO: Implement the method.
    return @[];
}

@end
