//
//  BRMArtist+JSONSerialization.h
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import <Foundation/Foundation.h>
#import "BRMArtist.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRMArtist (JSONSerialization)

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
