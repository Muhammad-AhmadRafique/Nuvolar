//
//  RepositoriesView.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "RepositoriesView.h"
#import "RepositoriesCollectionViewCell.h"
#import "GenericFetcher.h"
#import "URLBuilder.h"
#import "JsonParser.h"
#import "Constants.h"

@implementation RepositoriesView

NSMutableArray* reposList;

#pragma mark - Configure Methods

-(void) configureView:(NSString*)loginName {
    
    [reposList removeAllObjects];
    [_reposCollectionView reloadData];
    
    [_reposCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RepositoriesCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([RepositoriesCollectionViewCell class])];
    
    [_noRepositoriesLbl setHidden:YES];
    [_activityIndicator setHidden:NO];
    [self fetchRepos:loginName];
}

-(void) reloadViews {
    [_reposCollectionView reloadData];
}

#pragma mark - API Calls

-(void) fetchRepos:(NSString*)username {
    
    GenericFetcher *fetcher = [GenericFetcher new];
    NSString* apiURL = [NSString stringWithFormat:@"%@%@%@", kusers, username, @"/repos"];
    
    __weak typeof(self) weakSelf = self;
    [fetcher fetchWithUrl:[URLBuilder urlForMethod:apiURL withParameters:nil] withMethod:GET_REQUEST withParams:nil completionBlock:^(NSDictionary *dict1) {
        
        [weakSelf.activityIndicator setHidden:YES];
        JsonParser* parser = [[JsonParser alloc] init];
        reposList = [parser arrayOfReposWith:dict1];
        
        if (reposList.count == 0) {
            [weakSelf.noRepositoriesLbl setHidden:NO];
        } else {
            [weakSelf.noRepositoriesLbl setHidden:YES];
            [weakSelf.reposCollectionView reloadData];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"Error");
        [weakSelf.activityIndicator stopAnimating];
    }];
    
}

#pragma mark - UICollectionView Delegates

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RepositoriesCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RepositoriesCollectionViewCell class]) forIndexPath:indexPath];
    [cell configureCell:reposList[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return reposList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGRect bounds = [collectionView frame];
    CGFloat width = bounds.size.width;
    float cellWidth = (width/ 2.0); //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, 190);
    
    return size;
}

@end
