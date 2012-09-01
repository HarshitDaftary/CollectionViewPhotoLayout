//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import "PhotoLayout.h"

#define ITEM_SIZE 150

@interface PhotoLayout()
@property (nonatomic, assign) NSInteger firstRun;
@property (nonatomic, strong) NSDictionary *positions;
@end
@implementation PhotoLayout

- (void)setPinchedCellScale:(CGFloat)scale
{
    _pinchedCellScale = scale;
	
	// Just wanted to use delegate here for fun!
	if (self.pinchedCellScale > 3.5) {
		[self.delegate handleLargeScaleView:self];
	} else if (self.pinchedCellScale <= 3.5) {
		[self.delegate handleOriginalScaleView:self];
	}
	
	self.firstRun = 1;
    [self invalidateLayout];
}

- (void)setPinchedCellCenter:(CGPoint)origin
{
    _pinchedCellCenter = origin;
    [self invalidateLayout];
}

- (void)prepareLayout
{
    [super prepareLayout];
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}

- (CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
	
	if (self.firstRun == 0) {
		CGFloat x = 0, y = 0;
		CGFloat boundx = self.collectionView.frame.size.width * 1;	// Use the whole canvas
		CGFloat boundy = self.collectionView.frame.size.height * 1; // Use the whole canvas
		while (x < 15 || x > boundx) x = arc4random() % (int)boundx + indexPath.item * self.pinchedCellScale;
		while (y < 15 || y > boundy) y = arc4random() % (int)boundy + indexPath.item * self.pinchedCellScale;
		
		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		if (self.positions)
			dictionary = [self.positions mutableCopy];
		[dictionary setObject:[NSValue valueWithCGPoint:CGPointMake(x, y)] forKey:@(indexPath.item)];
		if (!self.positions)
			self.positions = [[NSDictionary alloc] init];
		self.positions = dictionary;
		
		attributes.center = CGPointMake(x, y);
	} else if (self.firstRun > 0 && self.pinchedCellScale >= 1) {
		CGPoint point = [[self.positions objectForKey:@(indexPath.item)] CGPointValue];
		attributes.center = CGPointMake(point.x, point.y);
	} else if (self.pinchedCellScale < 1.5) {
		int x, y;
		CGPoint point = [[self.positions objectForKey:@(indexPath.item)] CGPointValue];
		x = self.pinchedCellCenter.x - (self.pinchedCellCenter.x - point.x) * self.pinchedCellScale;
		y = self.pinchedCellCenter.y - (self.pinchedCellCenter.y - point.y) * self.pinchedCellScale;
		attributes.center = CGPointMake(x, y);
	}
	
	attributes.transform3D = CATransform3DMakeRotation((indexPath.item / 5 + 1) * 30, 0, 0, 0.5);
	[self applyPinchToLayoutAttributes:attributes];

    return attributes;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
	
    return attributes;
}

- (void)applyPinchToLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    if ([layoutAttributes.indexPath isEqual:self.pinchedCellPath]) {
		if (self.pinchedCellScale >= 1) {
			layoutAttributes.transform3D = CATransform3DMakeScale(self.pinchedCellScale, self.pinchedCellScale, 1.0);
			layoutAttributes.center = self.pinchedCellCenter;
			layoutAttributes.zIndex = 1;
		}
    }
}

@end
