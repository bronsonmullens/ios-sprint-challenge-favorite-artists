//
//  BRMArtistsTableViewController.m
//  Favorite Artists
//
//  Created by Bronson Mullens on 9/25/20.
//

#import "BRMArtistsTableViewController.h"
#import "BRMNewArtistViewController.h"
#import "BRMArtist.h"
#import "BRMArtistController.h"

@interface BRMArtistsTableViewController ()

@property (nonatomic) BRMArtistController *artistController;
@property (nonatomic) NSMutableArray *savedArtists;

@end

@implementation BRMArtistsTableViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSArray *loadedArtists = [self.artistController loadArtists];
    self.savedArtists = [[NSMutableArray alloc] initWithArray:loadedArtists];
    [self.tableView reloadData];
}

// Initializes a new instance of BRMArtistController if one is not present
- (BRMArtistController *)artistController {
    if (_artistController == nil) {
        _artistController = [[BRMArtistController alloc] init];
    }
    return _artistController;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.savedArtists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
    BRMArtist *artist = self.savedArtists[indexPath.row];
    if (artist.yearFormed != 0) {
        cell.textLabel.text = artist.artistName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Formed in %d", artist.yearFormed];
    } else {
        cell.textLabel.text = artist.artistName;
        cell.detailTextLabel.text = @"Year not found";
    }
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"NewArtistsSegue"]) {
        BRMNewArtistViewController *newArtistVC = (BRMNewArtistViewController *)segue.destinationViewController;
        newArtistVC.artistController = self.artistController;
    } else if ([segue.identifier isEqualToString:@"ArtistDetailSegue"]) {
        BRMNewArtistViewController *newArtistVC = (BRMNewArtistViewController *)segue.destinationViewController;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        newArtistVC.artist = self.savedArtists[selectedIndexPath.row];
    }
}

@end
