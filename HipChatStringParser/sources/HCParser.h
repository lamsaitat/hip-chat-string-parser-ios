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

@end


#endif /* HCParser_h */
