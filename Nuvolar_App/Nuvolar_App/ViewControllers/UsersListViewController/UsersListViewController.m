//
//  ViewController.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import "UsersListViewController.h"
#import "Constants.h"
#import "GenericFetcher.h"
#import "URLBuilder.h"
#import "JsonParser.h"
#import "UserDetailsViewController.h"
#import "SearchUsersListTableViewCell.h"
#import "UserModel.h"
#import "Router.h"
#import "UITableView+Category.h"
#import "UserHistory.h"
#import "HistoryTableViewCell.h"
#import "Enums.h"

@interface UsersListViewController ()

@property NSString* searchQuery;
@property int currentPage;
@property BOOL isLoading;
@property NSMutableArray* usersList;
@property NSMutableArray* historyList;
@property enum UserStatus status;

@end

@implementation UsersListViewController

#pragma mark -  View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _searchQuery = @"";
    _currentPage = 1;
    _isLoading = false;
    _status = history;
    _usersList = [[NSMutableArray alloc] init];
    _historyList = [[NSMutableArray alloc] init];
    
    [_tableView setTableFooterView:[[UIView alloc] init]];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UsersListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([UsersListTableViewCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SearchUsersListTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SearchUsersListTableViewCell class])];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HistoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HistoryTableViewCell class])];

    [self getUsersApiCall];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getHistory];
    [self showHideLabels];
}

#pragma mark -  API Calls

-(void) getUsersApiCall {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString* query = [NSString stringWithFormat:@"%@%@", _searchQuery, @"+in:login"];
    [params setValue:query forKey:kQuery];
    [params setValue:kUsers forKey:ktype];
    [params setValue:@"20" forKey:kper_page];
    [params setValue:[NSString stringWithFormat:@"%d", _currentPage] forKey:kpage];
        
    __weak typeof(self) weakSelf = self;
    GenericFetcher *fetcher = [GenericFetcher new];
    [fetcher fetchWithUrl:[URLBuilder urlForMethod:ksearch_user withParameters:params] withMethod:GET_REQUEST withParams:params completionBlock:^(NSDictionary *dict1) {
        
        JsonParser* parser = [[JsonParser alloc] init];
        NSMutableArray* list = [parser arrayOfUsersWithDictionary:dict1];
        [weakSelf pagination:list];
        
        [weakSelf showHideLabels];
        if (weakSelf.usersList.count == 0) {
            [weakSelf.tableView setAlpha:0];
        } else {
            [weakSelf.tableView setAlpha:1];
            [weakSelf.tableView reloadData];
        }
    } errorBlock:^(NSError *error) {
        NSLog(@"Error");
    }];
}

#pragma mark -  UITableView delegates

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if(_status == history) {
        HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HistoryTableViewCell class]) forIndexPath:indexPath];
        [cell configureCell:_historyList[indexPath.row]];
        return cell;
    } else if (_status == list) {
        UsersListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UsersListTableViewCell class]) forIndexPath:indexPath];
        [cell configureCell:_usersList[indexPath.row]];
        return cell;
    } else {
        SearchUsersListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SearchUsersListTableViewCell class]) forIndexPath:indexPath];
        [cell configureCell:_usersList[indexPath.row]];
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_status == history) {
        return _historyList.count;
    } else {
        return _usersList.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_status) {
        case searching:
            return 40;
            break;
        default:
            return 60;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString* userName = @"";
    
    if(_status == history) {
        UserModel* model = _historyList[indexPath.row];

        if([model isKindOfClass:[UserHistory class]]) {
            userName = model.loginName;
        }
        [self openUserDetailsScreen:userName];
    } else if (_status == list){
        UserModel* model = _usersList[indexPath.row];
        
        [self saveHistory:model];
        if([model isKindOfClass:[UserModel class]]) {
            userName = model.loginName;
        }
        [self openUserDetailsScreen:userName];
    } else {
        _status = list;
        [_tableView reloadData:YES];
    }
    
}

-(void) openUserDetailsScreen:(NSString*) userName {
    [[Router sharedInstance] openUserDetailsScreen:self.navigationController :userName];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
    
    if(_status != history) {
        if(_tableView.contentOffset.y >= (_tableView.contentSize.height - _tableView.frame.size.height)) {
            if(_isLoading == false) {
                _isLoading = true;
                _currentPage = _currentPage + 1;
                [self getUsersApiCall];
            }
        }
    }
}

#pragma mark -  Helper Methods

-(BOOL) isExist:(UserModel*) model {
    for (UserHistory* item in _historyList) {
        if ([item.loginName isEqualToString: model.loginName]) {
            return YES;
        }
    }
    return NO;
}

-(void) saveHistory:(UserModel*) model {
    
    if ([self isExist:model] == NO) {
        
        UserHistory* history = [[UserHistory alloc] init];
        NSArray* previousList = [history getHistory];
        
        history.loginName = model.loginName;
        history.avatarURL = model.avatarURL;
        
        NSArray* finalList = @[history];
        finalList = [finalList arrayByAddingObjectsFromArray:previousList];
        [history saveHistory:finalList];
    }
}

- (void) getHistory {
    UserHistory* history = [[UserHistory alloc] init];
    _historyList = [[history getHistory] mutableCopy];
}

- (void) pagination:(NSMutableArray*)list {
    if(_usersList.count > 0 && _currentPage != 1) {
        _usersList = [[_usersList arrayByAddingObjectsFromArray:list] mutableCopy];
    } else {
        _usersList = [list mutableCopy];
    }
    
    _isLoading = list.count == 0;
    [_tableView reloadData];
}

- (void) resetArrays {
    _searchQuery = @"";
    [_usersList removeAllObjects];
    _currentPage = 1;
    _isLoading = false;
    [_tableView reloadData];
}

-(void) showHideLabels {
    if((_status == searching || _status == list) && (_usersList.count == 0 || [_usersList isEqual: [NSNull null]])) {
        [_noUsersLbl setHidden:NO];
    } else if(_status == history && (_historyList.count == 0 || [_historyList isEqual: [NSNull null]])){
        [_noUsersLbl setHidden:NO];
    } else {
        [_noUsersLbl setHidden:YES];
    }
}

#pragma mark -  UISearchBar delegates

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    if ([searchBar.text isEqualToString: @""]) {
//        _status = history;
//    } else {
//        _status = searching;
//    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString: @""]) {
        _status = history;
        [_tableView removeShadow];
        [_recentlyViewedLbl setHidden:NO];
        [self showHideLabels];
        [self showHideSearchbarCancelButton:NO];
    } else {
        [self showHideSearchbarCancelButton:YES];
        _status = searching;
        [_recentlyViewedLbl setHidden:YES];
        [self showHideLabels];
        [_tableView addShadow];
    }
    [self resetArrays];
    _searchQuery = searchBar.text;
    [self getUsersApiCall];
}

-(void) showHideSearchbarCancelButton:(BOOL) isShow {
    [UIView transitionWithView:_searchBar
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        if (isShow) {
            [self->_searchBar setShowsCancelButton: YES];
        } else {
            [self->_searchBar setShowsCancelButton: NO];
        }
    }
                    completion:NULL];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if ([searchBar.text isEqualToString: @""]) {
        _status = history;
    } else {
        _status = list;
    }
    [_tableView reloadData:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self showHideSearchbarCancelButton:NO];
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    _status = history;
    [_tableView removeShadow];
    [self showHideLabels];
    [self resetArrays];
    _searchQuery = searchBar.text;
    [self getUsersApiCall];
}

@end
