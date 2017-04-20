//
//  ViewController.m
//  流水布局
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 com.taguage. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CustomCollectionLayoutDelegate>
@property (weak, nonatomic) IBOutlet CustomCollectionLayout *Layout;

@property (weak, nonatomic) IBOutlet UICollectionView *Collection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _Layout.delegate = self;
    [_Collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"-----第 %ld 个",(long)indexPath.row);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return arc4random() % 200 + 50;
}



@end
