//
//  ViewController.h
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import <UIKit/UIKit.h>
#import "UsersListTableViewCell.h"

@interface UsersListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UILabel *recentlyViewedLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *noUsersLbl;

@end

