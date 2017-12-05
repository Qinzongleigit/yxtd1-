

#import "UICountingLabel.h"

#define kPointsNumber 50 // 即数字跳100次
#define kDurationTime 2 // 动画时间
#define kStartNumber  0   // 起始数字
#define kEndNumber    1000// 结束数字


@interface UICountingLabel ()

@property (nonatomic, assign) int pointsNumber;
@property (nonatomic, assign) float durationTime;
@property (nonatomic, assign) float startNumber;
@property (nonatomic, assign) float endNumber;

@property (nonatomic, retain) NSMutableArray *numberPoints;//记录每次textLayer更改值的间隔时间及输出值。
@property (nonatomic, assign) float lastTime;
@property (nonatomic, assign) int indexNumber;

@end

@implementation UICountingLabel

- (void)cleanUpValue {
    _lastTime = 0;
    _indexNumber = 0;
    //可以取整数也可以取小数
    self.text = [NSString stringWithFormat:@"%.0f",_startNumber];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)jumpNumberWithDuration:(int)duration
                    fromNumber:(float)startNumber
                      toNumber:(float)endNumber {
    _durationTime = duration;
    _startNumber = startNumber;
    _endNumber = endNumber;
    
    [self cleanUpValue];
    [self initPoints];
    [self changeNumberBySelector];
}

- (void)jumpNumber {
    [self jumpNumberWithDuration:kDurationTime fromNumber:kStartNumber toNumber:kEndNumber];
}

- (void)initPoints {
    
    _numberPoints = [[NSMutableArray alloc] init];
    float dt;
    dt = 1.0 / (kPointsNumber - 1);
    for (int i = 0; i < kPointsNumber; i++) {
        float durationTime = dt * i  * _durationTime;
        float value = dt * i * (_endNumber - _startNumber) + _startNumber;
        [_numberPoints addObject:[NSArray arrayWithObjects:[NSNumber numberWithFloat:durationTime], [NSNumber numberWithFloat:value], nil]];
    }
}


- (void)changeNumberBySelector {
    if (_indexNumber >= kPointsNumber) {
        self.text = [NSString stringWithFormat:@"%.0f",_endNumber];
        return;
    } else {
        NSArray *pointValues = [_numberPoints objectAtIndex:_indexNumber];
        _indexNumber++;
        float value = [(NSNumber *)[pointValues objectAtIndex:1] intValue];// 有时要改成floatValue
        float currentTime = [(NSNumber *)[pointValues objectAtIndex:0] floatValue];
        float timeDuration = currentTime - _lastTime;
        _lastTime = currentTime;
        self.text = [NSString stringWithFormat:@"%.0f",value];
        [self performSelector:@selector(changeNumberBySelector) withObject:nil afterDelay:timeDuration];
    }
}


@end
