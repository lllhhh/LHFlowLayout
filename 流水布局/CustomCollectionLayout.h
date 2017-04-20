//
//  CustomCollectionLayout.h
//  流水布局
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 com.taguage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionLayoutDelegate <NSObject>

- (CGFloat) collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomCollectionLayout : UICollectionViewLayout

@property (assign,nonatomic) NSInteger numberOfSections;
@property (assign,nonatomic) NSInteger numberOfCellsInSections;
@property (assign,nonatomic) NSInteger columnCount;
@property (assign,nonatomic) CGFloat padding;

@property (weak,nonatomic) id<CustomCollectionLayoutDelegate> delegate;

@end
