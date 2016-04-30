//
//  HCParserFactory.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol HCParser;

@interface HCParserFactory : NSObject

/** Creates a parser instance that conforms to the HCParser protocol.
 */
+ (id<HCParser>)parser;

@end
