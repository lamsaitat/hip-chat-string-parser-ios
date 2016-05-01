//
//  HCObject.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#ifndef HCObject_h
#define HCObject_h

#import <Foundation/Foundation.h>

@protocol HCObject <NSObject>

- (instancetype)initWithDictionary:(NSDictionary *)sourceDictionary;

/** Converts conforming class's properties into a dictionary;
 */
@property(readonly, copy) NSDictionary *dictionary;

@end

#endif /* HCObject_h */
