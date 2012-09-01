//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout

@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) CGFloat pinchedCellScale;
@property (nonatomic, assign) CGPoint pinchedCellCenter;
@property (nonatomic, strong) NSIndexPath* pinchedCellPath;

@end
