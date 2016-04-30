//
//  HCParserFactory.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCParserFactory.h"
#import "HCParser.h"
#import "HCStubStringParser.h"

@implementation HCParserFactory

+ (id<HCParser>)parser {
    return [self.class stubParser];
}

+ (id<HCParser>)stubParser {
    return [HCStubStringParser new];
}

@end