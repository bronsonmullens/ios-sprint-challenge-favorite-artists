//
//  BRMArtistController.h
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BRMArtist;
typedef void (^CompletionHandler)(BRMArtist *_Nullable artist, NSError *_Nullable error);

@interface BRMArtistController : NSObject

- (void) fetchArtists:(NSString *)searchTerm
           completion:(CompletionHandler)completion;

- (NSArray *)loadArtists;

@end

NS_ASSUME_NONNULL_END
