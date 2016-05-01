//
//  HCLink.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCObject.h"

@interface HCLink : NSObject<HCObject>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *title;

@end
