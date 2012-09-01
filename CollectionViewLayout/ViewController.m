//
//  CollectionViewLayout
//
//  Created by Devon on 2012-07-09.
//  Copyright (c) 2012 Devon. All rights reserved.
//	https://github.com/fishpie
//

#import "ViewController.h"
#import "Cell.h"
#import "PhotoLayout.h"

@interface ViewController() <ScaledViewProtocol>
@end

@implementation ViewController

- (void)viewDidLoad
{
    self.cellCount = 20;
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"Cell"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
	UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [self.collectionView addGestureRecognizer:pinchRecognizer];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return self.cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Cell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
	cell.label.text = [NSString stringWithFormat:@"%d",indexPath.item];
	// Not sure why images are not showing up?!
	NSString *imageName = [NSString stringWithFormat:@"%d_thumb.jpg", indexPath.item + 1];
	cell.imageView.image = [UIImage imageNamed:imageName];
    return cell;
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
	PhotoLayout *photoLayout = (PhotoLayout *)self.collectionView.collectionViewLayout;
	
	if (sender.state == UIGestureRecognizerStateBegan) {
		CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
        NSIndexPath* pinchedCellPath = [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
		photoLayout.pinchedCellPath = pinchedCellPath;
	} else if (sender.state == UIGestureRecognizerStateChanged) {
        photoLayout.pinchedCellScale = sender.scale;
        photoLayout.pinchedCellCenter = [sender locationInView:self.collectionView];
    } else {
		CGPoint initialPinchPoint = [sender locationInView:self.collectionView];
		[[self.collectionView cellForItemAtIndexPath:[self.collectionView indexPathForItemAtPoint:initialPinchPoint]] setNeedsDisplay];
		// Uncomment the follow lines to restore original states after gestures end
//        [self.collectionView performBatchUpdates:^{
//            photoLayout.pinchedCellPath = nil;
//            photoLayout.pinchedCellScale = 1.0;
//        } completion:nil];
    }
}

#pragma mark - ScaledViewProtocol

- (void)handleLargeScaleView:(PhotoLayout *)sender
{
	// Cast spell here to make the detailed view look nice and stuff :)
	Cell *cell = (Cell *)[self.collectionView cellForItemAtIndexPath:sender.pinchedCellPath];
	cell.layer.shadowOffset = CGSizeMake(2.0, 0.0);
	cell.layer.shadowRadius = 10;
	cell.layer.shadowOpacity = 1.0;
	cell.label.font = [UIFont boldSystemFontOfSize:100.0];
	cell.label.text = @"LV";
	cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
}

- (void)handleOriginalScaleView:(PhotoLayout *)sender
{
	// Restore cell view back to its original state
	Cell *cell = (Cell *)[self.collectionView cellForItemAtIndexPath:sender.pinchedCellPath];
	cell.layer.shadowOffset = CGSizeMake(1.5, 0.0);
	cell.layer.shadowRadius = 5;
	cell.layer.shadowOpacity = 0.25;
	cell.label.font = [UIFont boldSystemFontOfSize:50.0];
	cell.label.text = [NSString stringWithFormat:@"%d", sender.pinchedCellPath.item];
}
@end
