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
@property (nonatomic, strong) NSArray* xAxisArray;


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
    self.view.backgroundColor = [UIColor cyanColor];
    ChartAxisBase* xAxis = self.myView.XAxis;
    xAxis.axisValueFormatter = [[XAxisFormtter alloc] init];
    xAxis.drawLabelsEnabled = YES;
    xAxis.centerAxisLabelsEnabled = YES;
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.labelFont = [UIFont systemFontOfSize:12];
    xAxis.labelTextColor = [UIColor colorWithHex:@"#999999"];
    xAxis.axisLineColor = [UIColor colorWithHex:@"#999999"];
    xAxis.axisLineWidth = 1.0;
    xAxis.maxLongLabelString = @"1234";
    xAxis.enabled = YES;
    xAxis.axisArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12"];
    
    //默认选择的highlight
    ChartHighlight* highLight = [[ChartHighlight alloc] init];
    highLight.enabled = YES;
    highLight.dataIndex = 2;
    highLight.hightlightLineMode = SolidModeHightlightLine;
    highLight.remindLabelMode = textStyleMode;
    self.highLightFor = [[HighLightFormatter alloc] init];
    self.myView.hightLight = highLight;
    
    SLLineChartDataSet* dataSet = [[SLLineChartDataSet alloc] initWithValues:self.tempArray1 label:@"Default"];
    dataSet.lineWidth = 1.5;
    dataSet.mode = brokenLineMode;
    dataSet.color = [UIColor colorWithHex:@"#fbc626"];
    dataSet.drawCirclesEnabled = NO;
    
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
    dataSource.graphColor = [UIColor whiteColor];
    
    [self.myView setScaleXEnabled:@(YES)];
    [self.myView setDynamicYAixs:@(NO)];
    [self.myView setBaseYValueFromZero:@(YES)];
    [self.myView setXlabelbottom:15];
    
    //设置的时候务必保证  VisibleXRangeDefaultmum 落在 VisibleXRangeMinimum 和 VisibleXRangeMaximum 否则将导致缩放功能不可用
    [self.myView setVisibleXRangeMaximum:@(50)];
    [self.myView setVisibleXRangeMinimum:@(2)];
    [self.myView setVisibleXRangeDefaultmum:@(10)];
    
    //直接调用Set方法和refreashDataSourceRestoreContext 和该方法等效
    [self.myView refreashDataSourceRestoreContext:_dataSource];
}

-(NSMutableArray*) tempArray0{
    if (_tempArray0 == nil) {
        _tempArray0 = [NSMutableArray arrayWithCapacity:1];
        NSArray *array = @[@"-1000", @"-1200", @"1000", @"900", @"1100", @"-1200", @"1000", @"900", @"1100", @"1000", @"900", @"380"];
        for (int i = 0; i < array.count; i++) {
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:[array[i] integerValue]];
            [_tempArray0 addObject:entry];
        }
    }
    return _tempArray0;
}

-(NSMutableArray*) tempArray1{
    if (_tempArray1 == nil) {
        _tempArray1 = [NSMutableArray arrayWithCapacity:1];
        NSArray *array = @[@"300", @"200", @"-250", @"210", @"260", @"300", @"200", @"-250", @"210", @"260", @"-250", @"210"];
        for (int i = 0; i < array.count; i++) {
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:[array[i] integerValue]];
            [_tempArray1 addObject:entry];
        }
    }
    return _tempArray1;
}


-(NSMutableArray*) tempArray2{
    if (_tempArray2 == nil) {
        _tempArray2 = [NSMutableArray arrayWithCapacity:1];
        NSArray *array = @[@"500", @"350", @"400", @"380", @"500", @"500", @"350", @"400", @"380", @"500", @"400", @"380"];
        for (int i = 0; i < array.count; i++) {
            ChartDataEntry* entry = [[ChartDataEntry alloc] initWithX:i y:[array[i] integerValue]];
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
