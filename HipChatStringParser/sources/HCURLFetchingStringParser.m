//
//  HCURLFetchingStringParser.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCURLFetchingStringParser.h"
#import <GDataXML-HTML/GDataXMLNode.h>
#import "HCMessage.h"
#import "HCLink.h"

@implementation HCURLFetchingStringParser

/**
 * Solution inspired by
 * http://stackoverflow.com/questions/26625487/is-it-possible-to-only-get-a-url-title-without-load-whole-wabpage
 * Using library GDataXML-HTML
 * https://github.com/graetzer/GDataXML-HTML
 */
- (NSURLSessionDataTask *)pageTitleForURL:(NSURL * __nonnull)url completionBlock:(nullable void(^)(NSString * __nullable, NSError * __nullable))completionBlock {
    NSParameterAssert(url != nil);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          NSString *title;
          NSError *blockError = nil;
          
          if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
              NSDictionary *headers = httpResponse.allHeaderFields;
              NSStringEncoding encoding = NSUTF8StringEncoding;
              
              // Do my best to recognise as much charset encoding I can find...
              NSString *charset = [headers[@"content-Type"] componentsSeparatedByString:@"; charset="].lastObject;
              if (charset && [charset isEqualToString:@"ISO-8859-1"]) {
                  encoding = NSISOLatin1StringEncoding;
              }
              
              if (data != nil && error == nil) {
                  NSString *htmlString = [[NSString alloc] initWithData:data encoding:encoding];
                  
                  if (htmlString.length > 0) {
                      NSError *parserError = nil;
                      
                      GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithHTMLString:htmlString encoding:NSUTF8StringEncoding error:&parserError];
                      
                      if (parserError == nil) {
                          for (GDataXMLElement *node in [doc nodesForXPath:@"//title" error:&parserError]) {
                              title = [node stringValue];
                              if (title != nil) {
                                  break;
                              }
                          }
                      }
                  }
              } else {
                  blockError = error;
              }
          }
          
          if (completionBlock) {
              completionBlock(title, blockError);
          }
      }];
    
    [dataTask resume];
    
    return dataTask;
}

- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithMessage:(HCMessage *)sourceMessage completionBlock:(nullable void(^)(HCMessage * __non_null, NSError * __nullable))completionBlock {
    __block NSMutableArray *tasks = [NSMutableArray array];
    __block typeof(sourceMessage) blockMessage = sourceMessage;
    
    if (sourceMessage.links.count == 0) {
        if (completionBlock) {
            completionBlock(sourceMessage, nil);
        }
    } else {
        for (HCLink *link in blockMessage.links) {
            __block typeof(link) blockLink = link;
            
            if (link.url) {
                NSURLSessionDataTask *task = [self pageTitleForURL:link.url completionBlock:^(NSString * _Nullable title, NSError * _Nullable pageTitleFetchError) {
                    if (pageTitleFetchError == nil && title) {
                        blockLink.title = title;
                    }
                    
                    // Check if any task is still active.
                    BOOL hasActiveTasks = NO;
                    for (NSURLSessionDataTask *leTask in tasks) {
                        hasActiveTasks = leTask.state == NSURLSessionTaskStateRunning;

                        if (hasActiveTasks) {
                            break;
                        }
                    }
                    if (hasActiveTasks == NO) {
                        if (completionBlock) {
                            completionBlock(blockMessage, pageTitleFetchError);
                        }
                    }
                }];
                [tasks addObject:task];
            }
        }
    }
    
    return tasks;
}

- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithDictionary:(NSDictionary *)sourceDictionary completionBlock:(nullable void(^)(NSDictionary * __nonnull, NSError * __nullable))completionBlock {
    
    NSMutableArray *tasks = [NSMutableArray array];
    NSMutableDictionary *dict = [sourceDictionary mutableCopy];
    
    // TODO: implement the logic to parse the string with parsers combined.
    if (completionBlock) {
        completionBlock(dict, nil);
    }
    
    return tasks;
}

@end
