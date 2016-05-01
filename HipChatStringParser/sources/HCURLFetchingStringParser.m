//
//  HCURLFetchingStringParser.m
//  HipChatStringParser
//
//  Created by Sai Tat Lam on 1/05/2016.
//  Copyright © 2016 Sai Tat Lam. All rights reserved.
//

#import "HCURLFetchingStringParser.h"
#import <GDataXML-HTML/GDataXMLNode.h>

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

- (NSArray<NSURLSessionDataTask *> *__nonnull)fetchPageTitlesWithDictionary:(NSDictionary *)sourceDictionary completionBlock:(nullable void(^)(NSDictionary * __nonnull, NSError * __nullable))completionBlock {
    
    NSMutableArray *tasks = [NSMutableArray array];
    NSMutableDictionary *dict = [sourceDictionary mutableCopy];
    
    // TODO: implement the logic to parse the string with parsers combined.
    if (completionBlock) {
        completionBlock(dict, nil);
    }
    
    return tasks;
}

- (NSURLSessionDataTask * __nullable)dictionaryFromString:(NSString * __nullable)sourceString completionBlock:(nullable void(^)(NSDictionary * __nullable, NSError * __nullable))completionBlock {
    NSURLSessionDataTask *dataTask = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // TODO: implement the logic to parse the string with parsers combined.
    
    if (dataTask == nil) {
        if (completionBlock) {
            completionBlock(dict, nil);
        }
    }
    
    return dataTask;
}

@end
