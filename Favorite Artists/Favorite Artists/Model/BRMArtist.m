//
//  BRMArtist.m
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import "BRMArtist.h"

@implementation BRMArtist

- (instancetype)initWithArtistName:(NSString *)anArtistName
                        yearFormed:(int)theYearFormed
                   artistBiography:(NSString *)theArtistBiography {
    self = [super init];
    if (self != nil) {
        _artistName = [anArtistName copy];
        _yearFormed = theYearFormed;
        _artistBiography = [theArtistBiography copy];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    NSString *stringArtistName = dictionary[@"stringArtist"];
    NSNumber *intYearFormed = dictionary[@"intFormedYear"];
    NSString *stringArtistBiography = dictionary[@"stringBiography"];
    
    return [self initWithArtistName:stringArtistName
                         yearFormed:intYearFormed.intValue
                    artistBiography:stringArtistBiography];
}

@end
