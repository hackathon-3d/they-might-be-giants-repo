//
//  RateItemCell.m
//  hownow
//
//  Created by Scott Means on 8/24/13.
//  Copyright (c) 2013 Scott Means. All rights reserved.
//

#import "RateItemCell.h"

@implementation RateItemCell

@synthesize deadStars=_deadStars, liveStars=_liveStars, checkList=_checkList;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CheckList *)checkList
{
    return _checkList;
}

- (void)setCheckList:(CheckList *)checkList
{
    _checkList = checkList;
    
    Rating *r = _checkList.myRating;
    
    if (r) {
        _liveStars.frame = CGRectMake(_deadStars.frame.origin.x, _deadStars.frame.origin.y,
                                       _deadStars.frame.size.width*(r.rating/5.0), _deadStars.frame.size.height);
    }
    
    _rateButton.hidden = !!r;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_checkList.myRating) {
        return;
    }
    
    UITouch *t = [touches anyObject];
    
    if (t.view == _deadStars) {
        CGPoint p = [t locationInView:t.view];
        
        CGFloat m = _deadStars.frame.size.width/10;
        
        CGFloat dx = ((int)(p.x/m)) * m;
        _liveStars.frame = CGRectMake(_deadStars.frame.origin.x, _deadStars.frame.origin.y,
                                      dx, _deadStars.frame.size.height);
    }
}

@end
