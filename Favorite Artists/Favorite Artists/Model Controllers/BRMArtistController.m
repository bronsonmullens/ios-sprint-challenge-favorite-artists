//
//  BRMArtistController.m
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import "BRMArtistController.h"
#import "BRMArtist.h"

// baseURL for networking calls
static NSString *baseURL = @"https://www.theaudiodb.com/api/v1/json/1/search.php?";

@implementation BRMArtistController

- (void)fetchArtists:(NSString *)searchTerm completion:(CompletionHandler)completion {
    // Setting up the URL
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURL];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"s" value:searchTerm]];
    NSURL *url = urlComponents.URL;
    
    // Setting up the session task
    NSURLSessionTask *task = [NSURLSession.sharedSession dataTaskWithURL:url
                                                       completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        if (data == nil) {
            completion(nil, error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:&jsonError];
        
        if (jsonError) {
            completion(nil, jsonError);
            return;
        }
        
        if ([dictionary[@"artists"] isKindOfClass:[NSNull class]]) {
            completion(nil, [[NSError alloc] init]);
            return;
        }
        
        NSDictionary *artist = [[dictionary objectForKey:@"artists"] firstObject];
        
        if (artist == nil) {
            completion(nil, [[NSError alloc] init]);
        }
        
        BRMArtist *artistResults = [[BRMArtist alloc] initWithDictionary:artist];
        completion(artistResults, nil);
    }];
    [task resume];
}

- (NSArray *)loadArtists {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex: 0];
    NSArray *filePath = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:documentsDirectory error:nil];
    NSMutableArray *artists = [[NSMutableArray alloc] init];
    
    for (NSString *artist in filePath) {
        NSString *artistPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", artist];
        NSURL *artistURL = [NSURL fileURLWithPath:artistPath];
        NSData *artistData = [[NSData alloc] initWithContentsOfURL:artistURL];
        NSDictionary *artistDictionary = [NSJSONSerialization JSONObjectWithData:artistData options:0 error:nil];
        BRMArtist *artist = [[BRMArtist alloc] initWithDictionary:artistDictionary];
        [artists addObject:artist];
    }
    return artists;
}

@end
