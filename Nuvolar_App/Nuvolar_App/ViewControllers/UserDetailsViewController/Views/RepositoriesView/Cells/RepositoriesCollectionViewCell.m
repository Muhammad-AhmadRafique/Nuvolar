//
//  RepositoriesCollectionViewCell.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/31/22.
//

#import "RepositoriesCollectionViewCell.h"
#import "UIView+Category.h"

@implementation RepositoriesCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [_mainView addShadow];

    [_imgContainer addShadow];
    [_imgContainer roundView];
    
}

-(void) configureCell:(RepoModel*) repo {
    
    if ([repo isKindOfClass:[RepoModel class]]) {
        
        _repositoryNameLbl.text = repo.fullName;
        NSString* description = repo.shortDescription;
        
        if ([description isEqual:(id)[NSNull null]] || [description isEqualToString:@""]) {
            _descriptionLbl.text = @"No description found...!";
        } else {
            _descriptionLbl.text = repo.shortDescription;
        }
        
        _isPublicLbl.text = repo.status;
       
        [self setupMainView];
    }
}

-(void) setupMainView {
    if( self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ){
        _mainView.backgroundColor = UIColor.systemGray6Color;
    } else {
        _mainView.backgroundColor = UIColor.systemBackgroundColor;
    }
}

@end
