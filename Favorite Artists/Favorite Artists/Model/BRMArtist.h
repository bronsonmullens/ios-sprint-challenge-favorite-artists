//
//  BRMArtist.h
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRMArtist : NSObject

@property (nonatomic, readonly, copy) NSString *artistName;
@property (nonatomic, readonly) int yearFormed;
@property (nonatomic, readonly, copy) NSString *artistBiography;

- (instancetype)initWithArtistName:(NSString *)anArtistName
                        yearFormed:(int)theYearFormed
                   artistBiography:(NSString *)theArtistBiography;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
