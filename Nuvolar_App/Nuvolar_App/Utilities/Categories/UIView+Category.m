//
//  UIView+Category.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 9/2/22.
//

#import "UIView+Category.h"

@implementation UIView (Category)

-(void) addShadow {
    [self.layer setCornerRadius:8];
    [self.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.layer setShadowRadius:2];
    [self.layer setShadowOpacity:0.5];
}

-(void) addLighterShadow {
    [self.layer setCornerRadius:8];
    [self.layer setShadowOffset:CGSizeMake(0, 2)];
    [self.layer setShadowRadius:2];
    [self.layer setShadowOpacity:0.2];
}

-(void) roundView {
    [self.layer setCornerRadius:self.frame.size.height/2];
}

@end
