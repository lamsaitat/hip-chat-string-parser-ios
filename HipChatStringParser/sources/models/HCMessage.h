//
//  HCMessage.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCObject.h"
@class HCLink;

@interface HCMessage : NSObject<HCObject>

@property (nonatomic, strong) NSString *chatMessage;

@property (nonatomic, strong) NSMutableArray *mentions;

@property (nonatomic, strong) NSMutableArray *emoticons;

@property (nonatomic, strong) NSMutableArray<HCLink *> *links;

@end
