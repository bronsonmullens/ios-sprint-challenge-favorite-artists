//
//  BRMArtist+JSONSerialization.m
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import "BRMArtist+JSONSerialization.h"

@implementation BRMArtist (JSONSerialization)

- (NSDictionary *)toDictionary {
    NSDictionary *dictionary = @{
        @"stringArtist": self.artistName,
        @"intFormedYear": [[NSNumber alloc] initWithInt:self.yearFormed],
        @"stringBiography": self.artistBiography
    };
    return dictionary;
}

@end
