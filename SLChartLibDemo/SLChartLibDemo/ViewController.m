//
//  ViewController.m
//  SLChartLibDemo
//
//  Created by smart on 2017/6/14.
//  Copyright © 2017年 Hadlinks. All rights reserved.
//

#import "ViewController.h"
#import "SLCurveChartLib.h"
#import "XAxisFormtter.h"
#import "YAxisFormtter.h"
#import "YRightAxisFormtter.h"
#import "HighLightFormatter.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet BaseCurveView *myView;
@property (nonatomic, strong) SLLineChartData* dataSource;
@property (nonatomic, strong) NSMutableArray* tempArray0;
@property (nonatomic, strong) NSMutableArray* tempArray1;
@property (nonatomic, strong) NSMutableArray* tempArray2;

@property (nonatomic, strong) SLGCDTimer timer;
@property (nonatomic, strong) HighLightFormatter *highLightFor;

- (IBAction)enableXscaleClick:(UIButton *)sender;
- (IBAction)enableDynamicYAxisClick:(UIButton *)sender;
- (IBAction)hiddenLeftYAxisClick:(UIButton *)sender;
- (IBAction)hiddenRightAxisClick:(UIButton *)sender;
- (IBAction)hiddenXAxisClick:(UIButton *)sender;
- (IBAction) curveOrStrightClick:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    ChartAxisBase* xAxis = self.myView.XAxis;
    xAxis.axisValueFormatter = [[XAxisFormtter alloc] init];
    xAxis.drawLabelsEnabled = YES;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.GridLinesMode = straightModeLine; // 网格线类型
    xAxis.labelFont = [UIFont systemFontOfSize:12];
    xAxis.labelTextColor = [UIColor colorWithHex:@"#999999"];
    xAxis.maxLongLabelString = @"1234";
    xAxis.enabled = YES;
    
    //默认选择的highlight
    ChartHighlight* highLight = [[ChartHighlight alloc] init];
    highLight.enabled = YES;
    highLight.dataIndex = 10;
    highLight.hightlightLineMode = SolidModeHightlightLine;
    highLight.remindLabelMode = textStyleMode;
    self.highLightFor = [[HighLightFormatter alloc] init];
//    highLight.delegate = self.highLightFor;
    self.myView.hightLight = highLight;
    
    
    SLLineChartDataSet* dataSet = [[SLLineChartDataSet alloc] initWithValues:self.tempArray1 label:@"Default"];
    dataSet.lineWidth = 1.5;
    dataSet.mode = brokenLineMode;
    dataSet.color = [UIColor colorWithHex:@"#fbc626"];
    dataSet.drawCirclesEnabled = NO;
    
    
//    dataSet.circleColor = [UIColor colorWithHex:@"#fbc626"];
//    dataSet.circleRadius = 3.0;
//    dataSet.circleHoleRadius = 3.0;
//    dataSet.drawCircleHoleEnabled = YES;
//    dataSet.gradientColors = @[[UIColor greenColor], [UIColor clearColor]];
    
    
    
    SLLineChartDataSet* dataSet2 = [[SLLineChartDataSet alloc] initWithValues:self.tempArray0 label:@"Default"];
    dataSet2.drawCirclesEnabled = NO;
    dataSet2.lineWidth = 1.0;
    dataSet2.mode = brokenLineMode;
    dataSet2.color = [UIColor colorWithHex:@"#fc83a9"];
    
    
    SLLineChartDataSet* dataSet3 = [[SLLineChartDataSet alloc] initWithValues:self.tempArray2 label:@"Default"];
    dataSet3.lineWidth = 1.0;
    dataSet3.mode = brokenLineMode;
    dataSet3.drawCirclesEnabled = NO;
    dataSet3.color = [UIColor colorWithHex:@"#7199ff"];
    
    
    NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity:1];
    [tempArray addObject:dataSet];
    [tempArray addObject:dataSet2];
    [tempArray addObject:dataSet3];
    SLLineChartData* dataSource = [[SLLineChartData alloc] initWithValues:tempArray];
    self.dataSource = dataSource;
    dataSource.graphColor = [UIColor clearColor];
    
    
    [self.myView setScaleXEnabled:@(YES)];
    [self.myView setDynamicYAixs:@(NO)];
    [self.myView setBaseYValueFromZero:@(YES)];
    
    //设置的时候务必保证  VisibleXRangeDefaultmum 落在 VisibleXRangeMinimum 和 VisibleXRangeMaximum 否则将导致缩放功能不可用
    [self.myView setVisibleXRangeMaximum:@(50)];
    [self.myView setVisibleXRangeMinimum:@(2)];
    [self.myView setVisibleXRangeDefaultmum:@(10)];
    
    //增加选配的基准线
//    ChartBaseLine* lineMax = [[ChartBaseLine alloc] init];
//    lineMax.lineWidth = 5;
//    lineMax.lineColor = [UIColor colorWithHex:@"#fbc626"];
//    lineMax.lineMode = ChartBaseLineStraightMode;
//    lineMax.yValue = 90;
//    
//    ChartBaseLine* lineMin = [[ChartBaseLine alloc] init];
//    lineMin.lineWidth = 0.5;
//    lineMin.lineColor = [UIColor purpleColor];
//    lineMin.lineMode = ChartBaseLineStraightMode;
//    lineMin.yValue = 30;
//    [self.myView addYBaseLineWith:lineMax];
//    [self.myView addYBaseLineWith:lineMin];
//    [self.myView setPageScrollerEnable:@(NO)];
    
    //直接调用Set方法和refreashDataSourceRestoreContext 和该方法等效
    [self.myView refreashDataSourceRestoreContext:_dataSource];
}

-(NSMutableArray*) tempArray0{
    if (_tempArray0 == nil) {
        _tempArray0 = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < 15; i++) {
            int temp = arc4random()%100 + 1;
            if (i < 20) {
                temp = arc4random()%50 + 1;
            }
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:temp];
            [_tempArray0 addObject:entry];
        }
    }
    return _tempArray0;
}

-(NSMutableArray*) tempArray1{
    if (_tempArray1 == nil) {
        _tempArray1 = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < 15; i++) {
            int temp = arc4random()%100 + 1;
            if (i < 20) {
                temp = arc4random()%50 + 1;
            }
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:temp];
            [_tempArray1 addObject:entry];
        }
    }
    return _tempArray1;
}


-(NSMutableArray*) tempArray2{
    if (_tempArray2 == nil) {
        _tempArray2 = [NSMutableArray arrayWithCapacity:1];
        for (int i = 0; i < 15; i++) {
            int temp = arc4random()%100 + 1;
            if (i < 20) {
                temp = arc4random()%50 + 1;
            }
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:temp];
            [_tempArray2 addObject:entry];
        }
    }
    return _tempArray2;
}

#pragma mark - 按键处理
- (IBAction)enableXscaleClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.myView setScaleXEnabled:@(NO)];
    }else{
        [self.myView setScaleXEnabled:@(YES)];
    }
}

- (IBAction)enableDynamicYAxisClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.myView setDynamicYAixs:@(YES)];
    }else{
        [self.myView setDynamicYAixs:@(NO)];
    }
}

- (IBAction)hiddenLeftYAxisClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.myView.leftYAxis.enabled = NO;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }else{
        self.myView.leftYAxis.enabled = YES;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }
}

- (IBAction)hiddenRightAxisClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.myView.rightYAxis.enabled = NO;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }else{
        self.myView.rightYAxis.enabled = YES;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }
}

- (IBAction)hiddenXAxisClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.myView.XAxis.enabled = NO;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }else{
        self.myView.XAxis.enabled = YES;
        [self.myView refreashDataSourceRestoreContext:self.dataSource];
    }
}

- (IBAction) curveOrStrightClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    for (SLLineChartDataSet* dataSet in self.dataSource.dataSets) {
        if (sender.selected) {
            dataSet.mode = brokenLineMode;
        }else{
            dataSet.mode = brokenLineMode;
        }
    }
    [self.myView refreashGraph];
}




@end
