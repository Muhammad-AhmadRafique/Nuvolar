//
//  UITableView+Category.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)

-(void) removeShadow {
    [self.layer setCornerRadius:0];
    [self.layer setShadowOffset:CGSizeMake(0, 0)];
    [self.layer setShadowRadius:0];
    [self.layer setShadowOpacity:0];
}

-(void) addShadow {
    [self.layer setCornerRadius:8];
    [self.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.layer setShadowRadius:2];
    [self.layer setShadowOpacity:0.5];
}

- (void)reloadData:(BOOL)animated
{
    [self reloadData];

    if (animated) {
        NSRange range = NSMakeRange(0, [self numberOfSections]);
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:range];
        [self reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
