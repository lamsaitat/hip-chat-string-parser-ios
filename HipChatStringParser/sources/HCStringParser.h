//
//  HCStringParser.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCParser.h"

@interface HCStringParser : NSObject<HCParser>

/** Unique set of mentions while preserving the order.
 */
- (NSOrderedSet<NSString *> *)uniqueMentionsFromString:(NSString *)sourceString;

@end
