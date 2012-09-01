//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import "CircleLayout.h"

#define ITEM_SIZE 150

@interface CircleLayout()
@property (nonatomic, assign) NSInteger firstRun;
@property (nonatomic, strong) NSDictionary *positions;
@end
@implementation CircleLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    _cellCount = [[self collectionView] numberOfItemsInSection:0];
}

-(CGSize)collectionViewContentSize
{
    return [self collectionView].frame.size;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
{
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
    attributes.size = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
	
	if (self.firstRun == 0) {
		CGFloat boundx = self.collectionView.frame.size.width / 3 * 2;
		CGFloat boundy = self.collectionView.frame.size.height / 3 * 2;

		int x = 0, y = 0;
		while (x < 15 || x >  boundx)
			x = arc4random() % (int)boundx + path.item * 10;
		
		while (y < 15 || y > boundy)
			y = arc4random() % (int)boundy + path.item * 10;

		NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
		if (self.positions)
			dictionary = [self.positions mutableCopy];
		[dictionary setObject:[NSValue valueWithCGPoint:CGPointMake(x, y)] forKey:@(path.item)];
		
		if (!self.positions)
			self.positions = [[NSDictionary alloc] init];
		
		self.positions = dictionary;
		
		attributes.center = CGPointMake(x, y);
	} else {
		CGPoint point = [[self.positions objectForKey:@(path.item)] CGPointValue];
		attributes.center = CGPointMake(point.x, point.y);
	}
	
	attributes.transform3D = CATransform3DMakeRotation((path.item / 5 + 1) * 30, 0, 0, 0.5);
	
	// pinch
	[self applyPinchToLayoutAttributes:attributes];

    return attributes;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray* attributes = [NSMutableArray array];
    for (NSInteger i=0 ; i < self.cellCount; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
	
    return attributes;
}

-(void)setPinchedCellScale:(CGFloat)scale
{
    _pinchedCellScale = scale;
	self.firstRun = 1;
    [self invalidateLayout];
}

- (void)setPinchedCellCenter:(CGPoint)origin {
    _pinchedCellCenter = origin;
    [self invalidateLayout];
}


-(void)applyPinchToLayoutAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes
{
    if ([layoutAttributes.indexPath isEqual:self.pinchedCellPath]) {
        layoutAttributes.transform3D = CATransform3DMakeScale(self.pinchedCellScale, self.pinchedCellScale, 1.0);
        layoutAttributes.center = self.pinchedCellCenter;
        layoutAttributes.zIndex = 1;
    }	
}

@end
