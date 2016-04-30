//
//  HCParserFactory.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCParserFactory.h"
#import "HCParser.h"
#import "HCStringParser.h"
#import "HCStubStringParser.h"
#import "HCURLFetchingStringParser.h"


@implementation HCParserFactory

+ (id<HCParser>)parser {
    return [self.class stringParser];
}

+ (id<HCParser>)stubParser {
    return [HCStubStringParser new];
}

+ (id<HCParser>)stringParser {
    return [HCStringParser new];
}

+ (HCURLFetchingStringParser *)urlFetchingParser {
    return [HCURLFetchingStringParser new];
}

@end
