//
//  BridgingHeader.h
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 30/04/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#ifndef BridgingHeader_h
#define BridgingHeader_h

#import "HCConstants.h"
#import "HCObject.h"
#import "HCMessage.h"
#import "HCLink.h"
#import "HCParserFactory.h"
#import "HCParser.h"
#import "HCStringParser.h"
#import "HCStubStringParser.h"
#import "HCURLFetchingStringParser.h"

// Libraries

//#import "GDataXMLNode.h"      // For some reason when compiling for real device Xcode fails to locate the GDataXMLNode.h file, but given that we do not use this library in the Swift area, there is no need to import such header into the bridging header.  So it's best to leave it out.
//#import <GDataXML-HTML/GDataXMLNode.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Reachability/Reachability.h>

#endif /* BridgingHeader_h */
