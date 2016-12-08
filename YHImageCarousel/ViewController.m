//
//  ViewController.m
//  YHImageCarousel
//
//  Created by zyh on 2016/12/8.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "ViewController.h"
#import "ImageCarouselView.h"
#import "CarouselSubview.h"
#import "CarouselCellInfo.h"

@interface ViewController () <ImageCarouselViewDelegate, ImageCarouselViewDataSource>

@property (nonatomic, strong) NSArray *cellInfoArray;
@property (nonatomic, strong) ImageCarouselView *imageCarouselView;
@property (nonatomic, assign) NSUInteger pageWidth;
@property (nonatomic, assign) NSUInteger pageHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageCarouselView = [[ImageCarouselView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.pageHeight) withDataSource:self withDelegate:self];
    [self.view addSubview:_imageCarouselView];
}

- (CGSize)sizeForPageInCarouselView:(ImageCarouselView *)carouselView {
    return CGSizeMake(self.pageWidth, self.pageHeight);
}

- (NSInteger)numberOfPagesInCarouselView:(ImageCarouselView *)carouselView {
    return self.cellInfoArray.count;
}

- (CarouselCell *)carouselView:(ImageCarouselView *)carouselView cellForPageAtIndex:(NSUInteger)index {
    CarouselCellImageView *cell = [[CarouselCellImageView alloc] initWithFrame:CGRectMake(0, 0, self.pageWidth - 4, self.pageHeight)];
    CarouselCellInfo *cellInfo = self.cellInfoArray[index];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", cellInfo.imageName]];
    cell.showTime = cellInfo.showTime;
    return cell;
}

- (void)carouselView:(ImageCarouselView *)carouselView didScrollToPage:(NSInteger)pageNumber {
    NSLog(@"滚动到第 %zd 页",pageNumber);
}

- (void)carouselView:(ImageCarouselView *)carouselView didSelectPageAtIndex:(NSInteger)index {
    NSLog(@"点击了第 %zd 页",index);
}

- (NSUInteger)pageWidth {
    return self.view.bounds.size.width * 0.84;
}

- (NSUInteger)pageHeight {
    return self.pageWidth * 0.6;
}

- (NSArray *)cellInfoArray {
    if (_cellInfoArray == nil) {
        
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"imageInfos.plist" ofType:nil]];
        // 2.创建一个可变数据
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        // 3.遍历字典数组,来做字典转模型
        for (NSDictionary *dict in dictArr) {
            // 把字典转换成模型同时添加到可变数组中
            [arrM addObject:[CarouselCellInfo cellInfoWithDict:dict]];
        }
        _cellInfoArray = arrM;
    }
    return _cellInfoArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
