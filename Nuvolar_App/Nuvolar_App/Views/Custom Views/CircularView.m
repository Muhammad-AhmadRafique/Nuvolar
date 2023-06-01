//
//  CircularView.m
//  Nuvolar_App
//
//  Created by Ahmad Rafiq on 8/30/22.
//

#import "CircularView.h"

@implementation CircularView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setupView];
    }
    return self;
}

-(void) setupView {
    [self.layer setCornerRadius:(self.frame.size.height/2)];
    [self.layer setMasksToBounds: YES];
}

@end
