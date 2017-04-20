//
//  CustomCollectionLayout.m
//  流水布局
//
//  Created by 刘欢 on 2017/4/19.
//  Copyright © 2017年 com.taguage. All rights reserved.
//

#import "CustomCollectionLayout.h"

@interface CustomCollectionLayout()

@property (strong,nonatomic) NSMutableArray *attributeArr;
@property (strong,nonatomic) NSMutableArray *cellXArray;
@property (strong,nonatomic) NSMutableArray *cellYArray;
@property (assign,nonatomic) CGFloat cellWidth;

@end

@implementation CustomCollectionLayout

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#pragma getter and setter

//- (NSInteger)columnCount
//{
//    if (_columnCount == 0) {
//        _columnCount = 2;
//    }
//    
//    return _columnCount;
//}
//
//- (CGFloat)padding
//{
//    if (_padding == 0) {
//        _padding = 5;
//    }
//    return _padding;
//}

//prepareLayout

- (void)prepareLayout
{
    [super prepareLayout];
    [self initData];
    [self initCellWidth];
    [self initCellYArray];
    [self configLayout];
}

//返回collectionview 的 Contentsize
- (CGSize)collectionViewContentSize
{
    CGFloat height = [self maxCellYArrayWithArray:_cellYArray];
    return CGSizeMake(SCREEN_WIDTH , height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributeArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  _attributeArr[indexPath.row];
}

#pragma mark - help Methods

- (void)configLayout{
    
        for (int i = 0; i < _numberOfCellsInSections; i ++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
            CGRect frame = CGRectZero;
            
            if ([self.delegate respondsToSelector:@selector(collectionView:heightForItemAtIndexPath:)]) {
                CGFloat cellHeight = [_delegate collectionView:self.collectionView heightForItemAtIndexPath:indexpath];
                NSInteger minYindex = [self minCellYArrayWithArray:_cellYArray];
                CGFloat tmpX = [[_cellXArray objectAtIndex:minYindex] floatValue];
                CGFloat tmpY = [[_cellYArray objectAtIndex:minYindex] floatValue];
                frame = CGRectMake(tmpX, tmpY, _cellWidth, cellHeight);
                _cellYArray[minYindex] = @(tmpY + cellHeight + _padding);
                
                attributes.frame = frame;
                [_attributeArr addObject:attributes];
            }
        }
}

- (void)initData{
    _attributeArr = [NSMutableArray arrayWithCapacity:0];
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
    
    if (_columnCount == 0) {
        _columnCount = 2;
    }
    if (_padding == 0) {
        _padding = 5;
    }
}

- (void)initCellWidth{
    _cellWidth =  (SCREEN_WIDTH - (_columnCount - 1) * _padding) / _columnCount;
    
    _cellXArray = [NSMutableArray arrayWithCapacity:_columnCount];
    
    for (int i = 0; i < _columnCount; i++) {
        CGFloat tmpX = i * (_cellWidth + _padding);
        [_cellXArray addObject:@(tmpX)];
    }
}

- (void) initCellYArray{
    _cellYArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i++ ) {
        [_cellYArray addObject:@(0)];
    }
}

/**
 * 求CellY数组中的最大值并返回
 */
- (CGFloat) maxCellYArrayWithArray: (NSMutableArray *) array{
    if (array.count == 0) {
        return 0.0f;
    }
    
    CGFloat max = [array[0] floatValue];
    for (NSNumber *number in array) {
        
        CGFloat temp = [number floatValue];
        
        if (max < temp) {
            max = temp;
        }
    }
    
    return max;
}

/**
 * 求CellY数组中的最小值的索引
 */
- (CGFloat) minCellYArrayWithArray: (NSMutableArray *) array{
    
    if (array.count == 0) {
        return 0.0f;
    }
    
    NSInteger minIndex = 0;
    CGFloat min = [array[0] floatValue];
    
    for (int i = 0; i < array.count ; i++ ) {
        CGFloat temp = [array[i] floatValue];
        
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    
    return minIndex;
}

@end
