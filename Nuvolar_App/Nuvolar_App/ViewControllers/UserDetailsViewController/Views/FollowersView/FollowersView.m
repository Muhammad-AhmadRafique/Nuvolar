//
//  FollowersView.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "FollowersView.h"
#import "FollowersTableViewCell.h"
#import "GenericFetcher.h"
#import "URLBuilder.h"
#import "JsonParser.h"
#import "Constants.h"
#import "UITableView+Category.h"

@implementation FollowersView

NSMutableArray* followersList;

#pragma mark - Configure Methods

-(void) configureView:(NSString*)loginName {
    
    [followersList removeAllObjects];
    [_tableView reloadData:YES];
    
    [_tableView setTableFooterView:[[UIView alloc] init]];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FollowersTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([FollowersTableViewCell class])];
    
    [_noFollowersLbl setHidden:YES];
    [_activityIndicator setHidden:NO];
    [self fetchFollowers:loginName];
}

#pragma mark - API Calls

-(void) fetchFollowers:(NSString*)username {
    
    GenericFetcher *fetcher = [GenericFetcher new];
    NSString* apiURL = [NSString stringWithFormat:@"%@%@%@", kusers, username, @"/followers"];
    
    __weak typeof(self) weakSelf = self;
    [fetcher fetchWithUrl:[URLBuilder urlForMethod:apiURL withParameters:nil] withMethod:GET_REQUEST withParams:nil completionBlock:^(NSDictionary *dict1) {
        
        [weakSelf.activityIndicator setHidden:YES];

        JsonParser* parser = [[JsonParser alloc] init];
        followersList = [parser arrayOfFollowersWith:dict1];
        
        if (followersList.count == 0) {
            [weakSelf.noFollowersLbl setHidden:NO];
        } else {
            [weakSelf.noFollowersLbl setHidden:YES];
            [weakSelf.tableView reloadData:YES];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"Error");
        [weakSelf.activityIndicator stopAnimating];
    }];
    
}

#pragma mark - UITableView Delegates

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FollowersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FollowersTableViewCell class]) forIndexPath:indexPath];
    [cell configureCell:followersList[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return followersList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end
