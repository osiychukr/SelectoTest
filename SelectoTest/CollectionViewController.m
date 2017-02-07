//
//  CollectionViewController.m
//  SelectoTest
//
//  Created by Roma Osiychuk on 06.02.17.
//  Copyright © 2017 Roma Osiychuk. All rights reserved.
//

#import "CollectionViewController.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface CollectionViewController ()
@property (strong, nonatomic) NSArray* animatedImages;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.animatedImages = [NSArray arrayWithObjects:@"200w", @"arnold", @"ball", @"cat", @"catch", @"deadman", @"elephant", @"money", @"skate", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>
-(UICollectionViewCell*) collectionView:(UICollectionView*) collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    
    
    static NSString* identifier = @"Cell";
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    NSString* nameFile = [self.animatedImages objectAtIndex:indexPath.row];

    NSURL* path = [[NSBundle mainBundle] URLForResource:nameFile withExtension:@"gif"];
    NSData *dataImage = [NSData dataWithContentsOfURL:path];
    FLAnimatedImageView* imageView1 = [[FLAnimatedImageView alloc] init];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.clipsToBounds = YES;
    
    [cell addSubview:imageView1];
    imageView1.frame = CGRectMake(CGRectGetMinX(cell.bounds), CGRectGetMinY(cell.bounds), CGRectGetMaxX(cell.bounds), CGRectGetMaxY(cell.bounds));

    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:dataImage];
    imageView1.animatedImage = animatedImage1;
    
    return cell;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.animatedImages.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
