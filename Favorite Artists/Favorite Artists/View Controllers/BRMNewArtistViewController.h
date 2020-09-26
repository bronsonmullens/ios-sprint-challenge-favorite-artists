//
//  BRMNewArtistViewController.h
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import <UIKit/UIKit.h>
#import "BRMArtistController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BRMNewArtistViewController : UIViewController

@property (nonatomic, assign) BRMArtistController *artistController;
@property (nonatomic, assign) BRMArtist *artist;

@end

NS_ASSUME_NONNULL_END
