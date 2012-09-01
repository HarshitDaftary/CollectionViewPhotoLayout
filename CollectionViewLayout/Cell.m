//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import "Cell.h"

@implementation Cell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		// Label
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:50.0];
        label.backgroundColor = [UIColor underPageBackgroundColor];
        label.textColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        _label = label;
		
		// ImageView
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
		imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
		imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:self.imageView];
		_imageView = imageView;
        self.contentView.layer.borderWidth = 2.0;
        self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
		
		self.layer.shadowOffset = CGSizeMake(1.5, 0.0);
		self.layer.shadowColor = [[UIColor blackColor] CGColor];
		self.layer.shadowRadius = 5;
		self.layer.shadowOpacity = 0.25;
    }
    return self;
}

@end
