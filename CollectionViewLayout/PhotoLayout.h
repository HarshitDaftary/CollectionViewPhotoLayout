//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import <UIKit/UIKit.h>

@protocol ScaledViewProtocol;

@interface PhotoLayout : UICollectionViewLayout
@property (nonatomic, assign) NSInteger cellCount;
@property (nonatomic, assign) CGFloat pinchedCellScale;
@property (nonatomic, assign) CGPoint pinchedCellCenter;
@property (nonatomic, strong) NSIndexPath* pinchedCellPath;
@property (nonatomic, weak) id <ScaledViewProtocol> delegate;
@end

@protocol ScaledViewProtocol <NSObject>
@optional
- (void)handleLargeScaleView:(PhotoLayout *)sender;
- (void)handleOriginalScaleView:(PhotoLayout *)sender;
@end