//
//  Translater.m
//  translater
//
//  Created by admin on 30.11.16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "Translater.h"


@interface Translater ()

@property(strong, nonatomic) id<TranslaterProtocol> delegate;

@end
static NSString* keyAPI = @"trnsl.1.1.20161130T082831Z.ab23c528625523b1.aaa3f4232de544631375f1fabb32c55768249ddf";
static NSString* baseRequest = @"https://translate.yandex.net/api/v1.5/tr.json/translate";


@implementation Translater

- (instancetype)initWithDelegate:(id<TranslaterProtocol>)delegate {
    
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        
    }
    return self;
}


- (void) translate:(NSString *)text and:(NSString*)lang {
    
    NSString *postDataString = [NSString stringWithFormat:@"key=%@&text=%@&lang=%@", keyAPI, text, lang];

    NSURL *url = [NSURL URLWithString:baseRequest];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = [postDataString dataUsingEncoding:NSUTF8StringEncoding];

    request.HTTPMethod = @"POST";

    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSArray *answerData;
        
        if (error) {
            NSLog(@"Error: \n%@", error);
            answerData = @[@"Error"];
        } else {
            
            NSDictionary *answer = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"%@", answer);
            NSInteger statusCode = [[answer valueForKey:@"code"] integerValue];
            
            if (statusCode == 200) {
                
                answerData = [answer valueForKey:@"text"];
                NSLog(@"Answer: \n%@", [[answer valueForKey:@"text"] firstObject]);
                
            } else {
                answerData = @[@"Error"];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate receiveData:answerData];
        });
        
    }] resume];
    
    
}
@end
