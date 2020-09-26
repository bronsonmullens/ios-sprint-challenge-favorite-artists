//
//  BRMNewArtistViewController.m
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import "BRMNewArtistViewController.h"
#import "BRMArtist.h"
#import "BRMArtistController.h"
#import "BRMArtist+JSONSerialization.h"

@interface BRMNewArtistViewController ()

@property (nonatomic) BRMArtist *artistSearch;
@property (nonatomic) BOOL artistFound;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITextView *biorgraphyTextView;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearFormedLabel;

@end

@implementation BRMNewArtistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.artist != nil) {
        self.artistFound = YES;
    } else {
        self.artistFound = NO;
        [self updateViews];
    }
}

- (void)updateViews {
    if (self.artistFound == YES) {
        self.title = self.artist.artistName;
        self.artistNameLabel.text = self.artist.artistName;
        
        if (self.artist.yearFormed == 0) {
            self.yearFormedLabel.text = @"Empty";
        } else {
            self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed in %d", self.artist.yearFormed];
        }
        
        self.biorgraphyTextView.text = self.artist.artistBiography;
    } else {
        self.artistNameLabel.text = self.artistSearch.artistName;
        if (self.artistSearch.yearFormed == 0) {
            self.yearFormedLabel.text = @"No Results";
        } else {
            self.yearFormedLabel.text = [NSString stringWithFormat:@"Formed in %d", self.artistSearch.yearFormed];
        }
        self.biorgraphyTextView.text = self.artistSearch.artistBiography;
    }
}

- (IBAction)saveButtonTapped:(id)sender {
    if (self.artistSearch == nil) {
        return;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:[self.artistSearch toDictionary] options:0 error:nil];
    NSURL *directory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                              inDomain:NSUserDomainMask
                                                     appropriateForURL:nil
                                                                create:YES
                                                                 error:nil];
    NSURL *url = [[directory URLByAppendingPathComponent:self.artistSearch.artistName] URLByAppendingPathExtension:@"json"];
    
    [data writeToURL:url atomically:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

@implementation BRMNewArtistViewController(UISearchBarDelegate)

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.artistController fetchArtists:searchBar.text completion:^(BRMArtist *_Nullable artist, NSError *_Nullable error) {
        if (error) {
            NSLog(@"Could not fetch artist");
        }
        self.artistSearch = artist;
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self updateViews];
        });
    }];
}

@end
