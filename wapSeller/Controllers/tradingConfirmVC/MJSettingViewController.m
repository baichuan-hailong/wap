//
//  MJSettingViewController.m
//  wapSeller
//
//  Created by 杜海龙 on 2017/11/28.
//  Copyright © 2017年 mjyg. All rights reserved.
//

#import "MJSettingViewController.h"
#import "MJSettingView.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface MJSettingViewController ()<CBCentralManagerDelegate,IFlySpeechSynthesizerDelegate>
@property(nonatomic, strong)MJSettingView *settingView;
typedef NS_ENUM(NSInteger, BluetoothState){
    BluetoothStateDisconnect = 0,
    BluetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting
};

typedef NS_ENUM(NSInteger, BluetoothFailState){
    BluetoothFailStateUnExit = 0,
    BluetoothFailStateUnKnow,
    BluetoothFailStateByHW,
    BluetoothFailStateByOff,
    BluetoothFailStateUnauthorized,
    BluetoothFailStateByTimeout
};

/** ke da xun fei **/
typedef NS_OPTIONS(NSInteger, SynthesizeType) {
    NomalType           = 5,    //Normal TTS
    UriType             = 6,    //URI TTS
};

//state of TTS
typedef NS_OPTIONS(NSInteger, Status) {
    NotStart            = 0,
    Playing             = 2,
    Paused              = 4,
};

@property (strong , nonatomic) UITableView *tableView;

@property (strong , nonatomic) CBCentralManager   *manager;//中央设备
@property (assign , nonatomic) BluetoothFailState bluetoothFailState;
@property (assign , nonatomic) BluetoothState     bluetoothState;

@property (strong , nonatomic) CBPeripheral     *discoveredPeripheral;//周边设备
@property (strong , nonatomic) CBCharacteristic *characteristic1;    //周边设备服务特性
@property (strong , nonatomic) NSMutableArray   *BleViewPerArr;


/** ke da xun fei **/
@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;
@property (nonatomic, strong) NSString       *uriPath;
@property (nonatomic, strong) PcmPlayer      *audioPlayer;
@property (nonatomic, assign) Status         state;
@property (nonatomic, assign) SynthesizeType synTyp;

@end

@implementation MJSettingViewController

+(instancetype)shareManager{
    static MJSettingViewController  *settingVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingVC = [[MJSettingViewController alloc] init];
    });
    return settingVC;
}

- (void)loadView{
    self.settingView = [[MJSettingView alloc] initWithFrame:SCREEN_BOUNDS];
    self.view = self.settingView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交易确认设置";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:247/255.0 alpha:1];
    [self.settingView.mySwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
 
    
    
    
    
    
    /** ke da xun fei **/
    TTSConfig *instance = [TTSConfig sharedInstance];
    if (instance == nil) {
        return;
    }
    //TTS singleton
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    _iFlySpeechSynthesizer.delegate = self;
    //set speed,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
    //set volume,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
    //set pitch,range from 1 to 100.
    [_iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
    //set sample rate
    [_iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    //set TTS speaker
    [_iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
    //set text encoding mode
    [_iFlySpeechSynthesizer setParameter:@"unicode" forKey:[IFlySpeechConstant TEXT_ENCODING]];
    
    NSString *prePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //Set the audio file name for URI TTS
    _uriPath = [NSString stringWithFormat:@"%@/%@",prePath,@"uri.pcm"];
    //Instantiate player for URI TTS
    _audioPlayer = [[PcmPlayer alloc] init];
}


- (void)viewWillAppear:(BOOL)animated{
    //Central
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    //self.manager.delegate = self;
    self.BleViewPerArr = [[NSMutableArray alloc] initWithCapacity:1];
}



#pragma mark - IFlySpeechSynthesizerDelegate
/**
 callback of starting playing
 Notice：
 Only apply to normal TTS
 **/
- (void)onSpeakBegin{
    NSLog(@"on speak begin");
}



/**
 callback of buffer progress
 Notice：
 Only apply to normal TTS
 **/
- (void)onBufferProgress:(int) progress message:(NSString *)msg{
    NSLog(@"buffer progress %2d%%. msg: %@.", progress, msg);
}




/**
 callback of playback progress
 Notice：
 Only apply to normal TTS
 **/
- (void) onSpeakProgress:(int) progress beginPos:(int)beginPos endPos:(int)endPos{
    NSLog(@"speak progress %2d%%.", progress);
}

/**
 callback of pausing player
 Notice：
 Only apply to normal TTS
 **/
- (void)onSpeakPaused{
    NSLog(@"on speak paused");
}

/**
 callback of TTS completion
 **/
- (void)onCompleted:(IFlySpeechError *) error{
    NSLog(@"%s,error=%d",__func__,error.errorCode);
    if (error.errorCode != 0) {
        NSLog(@"error");
        return;
    }
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:_uriPath]) {
        [self playUriAudio];//play the audio file generated by URI TTS
    }
}



#pragma mark - Playing For URI TTS
- (void)playUriAudio{
    TTSConfig *instance = [TTSConfig sharedInstance];
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    _audioPlayer = [[PcmPlayer alloc] initWithFilePath:_uriPath sampleRate:[instance.sampleRate integerValue]];
    [_audioPlayer play];
    
}






-(void)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"on");
        [_iFlySpeechSynthesizer startSpeaking:@"蓝牙开启成功"];
        self.settingView.stateImageView.image = [UIImage imageNamed:@"state_on_image"];
        [MJLabelManager setLabel:self.settingView.stateLabel
                            text:@"扫描枪已连接"
                       textColor:[UIColor colorWithHex:@"25c740"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*48]];
        
        //[self scan];
    }else {
        NSLog(@"off");
        self.settingView.stateImageView.image = [UIImage imageNamed:@"state_off_image"];
        [MJLabelManager setLabel:self.settingView.stateLabel
                            text:@"扫描枪未连接"
                       textColor:[UIColor colorWithHex:@"f52414"]
                   textAlignment:NSTextAlignmentCenter
                            font:[UIFont systemFontOfSize:em*48]];
    }
}



- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    NSString *message;
    switch (central.state) {
        case 1:
            message = @"该设备不支持蓝牙功能,请检查系统设置";
            [self bluetoothac];
            break;
        case 2:
            message = @"该设备蓝牙未授权,请检查系统设置";
            [self bluetoothac];
            break;
        case 3:
            message = @"该设备蓝牙未授权,请检查系统设置";
            [self bluetoothac];
            break;
        case 4:
            message = @"该设备尚未打开蓝牙,请在设置中打开";
            [self bluetoothac];
            break;
        case 5:
            message = @"蓝牙已经成功开启,请稍后再试";
            break;
        default:
            message = @"暂无";
            break;
    }
    if(message!=nil&&message.length!=0){
        NSLog(@"message == %@",message);
    }
}



- (void)bluetoothac{
    [_iFlySpeechSynthesizer startSpeaking:@"请在设置中开启蓝牙并连接扫码枪"];
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"请在设置中开启蓝牙并连接扫码枪!"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置"
                                                       style:UIAlertActionStyleCancel
                                                     handler:^(UIAlertAction *action) {
                                            
                                                         NSString * urlStr = @"App-Prefs:root=Bluetooth";
                                                         if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
                                                             if (iOS10_mj) {
                                                                 //iOS10.0以上
                                                                 if(@available(iOS 10.0, *)){
                                                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
                                                                 }//Fallback on earlier versions
                                                             } else{
                                                                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
                                                             }
                                                         }
                                                     }];
    
    
    UIAlertAction *cancle  = [UIAlertAction actionWithTitle:@"好"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
                                                        NSLog(@"cancle");
                                                    }];
    
    [cancle setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [okAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [alertDialog addAction:okAction];
    [alertDialog addAction:cancle];
    [self presentViewController:alertDialog animated:YES completion:nil];
}



//开始扫描
-(void)scan{
    //记录目前是扫描状态
    _bluetoothState = BluetoothStateScaning;
    //清空所有外设数组
    [self.BleViewPerArr removeAllObjects];
    //如果蓝牙状态未开启，提示开启蓝牙
    if(_bluetoothFailState==BluetoothFailStateByOff){
        NSLog(@"%@",@"检查您的蓝牙是否开启后重试");
    }else{
       [self.manager scanForPeripheralsWithServices:nil options:nil];
    }
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    if (peripheral == nil||peripheral.identifier == nil||peripheral.name == nil){
        // return;
    }
    NSString *pername=[NSString stringWithFormat:@"%@",peripheral.name];
    //判断是否存在@"你的设备名"
    NSRange range=[pername rangeOfString:@"你的设备名"];
    //如果从搜索到的设备中找到指定设备名，和BleViewPerArr数组没有它的地址
    
    NSLog(@"peripheral --- %@",peripheral);
    NSLog(@"搜索到了设备：%@",pername);
    
    //加入BleViewPerArr数组
    if(range.location!=NSNotFound&&[_BleViewPerArr containsObject:peripheral]==NO){
        [_BleViewPerArr addObject:peripheral];
    }
    _bluetoothFailState = BluetoothFailStateUnExit;
    _bluetoothState = BluetoothStateScanSuccess;
    [_tableView reloadData];
}


- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    NSLog(@"1");
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    NSLog(@"1");
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    NSLog(@"1");
}



- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    NSLog(@"1");
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"1");
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"1");
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {

    NSLog(@"1");
}

- (void)setNeedsFocusUpdate {
    NSLog(@"1");
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    NSLog(@"1");
    return YES;
}

- (void)updateFocusIfNeeded {
    NSLog(@"1");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end











/******************************************************************************************/




/**
 
 #pragma mark - Delegate
 -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"IsConnect"];
 if (cell == nil) {
 cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IsConnect"];
 }
 // 将蓝牙外设对象接出，取出name，显示
 //蓝牙对象在下面环节会查找出来，被放进BleViewPerArr数组里面，是CBPeripheral对象
 CBPeripheral *per=(CBPeripheral *)_BleViewPerArr[indexPath.row];
 NSString *bleName=[per.name substringWithRange:NSMakeRange(0, 9)];
 cell.textLabel.text = per.name;
 return cell;
 }
 
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 return 44;
 }
 -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 return _BleViewPerArr.count;
 }
 
 //链接设备
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 CBPeripheral *peripheral=(CBPeripheral *)_BleViewPerArr[indexPath.row];
 //设定周边设备，指定代理者
 _discoveredPeripheral = peripheral;
 _discoveredPeripheral.delegate = self;
 //连接设备
 [_manager connectPeripheral:peripheral
 options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
 }
 
 
 // 获取当前设备
 - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
 NSLog(@"%@",peripheral);
 // 设置设备代理
 [peripheral setDelegate:self];
 // 大概获取服务和特征
 [peripheral discoverServices:nil];
 //或许只获取你的设备蓝牙服务的uuid数组，一个或者多个
 //[peripheral discoverServices:@[[CBUUID UUIDWithString:@""],[CBUUID UUIDWithString:@""]]];
 NSLog(@"Peripheral Connected");
 [_manager stopScan];
 NSLog(@"Scanning stopped");
 _bluetoothState=BluetoothStateConnected;
 }
 
 - (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
 
 }
 
 
 // 获取当前设备服务services
 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
 if (error) {
 NSLog(@"Error discovering services: %@", [error localizedDescription]);
 return;
 }
 NSLog(@"所有的servicesUUID%@",peripheral.services);
 //遍历所有service
 for (CBService *service in peripheral.services){
 NSLog(@"服务%@",service.UUID);
 //找到你需要的servicesuuid
 if ([service.UUID isEqual:[CBUUID UUIDWithString:@"你的设备服务的uuid"]]){
 //监听它
 [peripheral discoverCharacteristics:nil forService:service];
 }
 }
 NSLog(@"此时链接的peripheral：%@",peripheral);
 }
 
 
 //特征获取
 - (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
 if (error){
 NSLog(@"Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
 return;
 }
 NSLog(@"服务：%@",service.UUID);
 // 特征
 for (CBCharacteristic *characteristic in service.characteristics){
 NSLog(@"%@",characteristic.UUID);
 //发现特征
 //注意：uuid 分为可读，可写，要区别对待！！！
 if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"你的特征uuid"]]){
 NSLog(@"监听：%@",characteristic);//监听特征
 //保存characteristic特征值对象
 //以后发信息也是用这个uuid
 _characteristic1 = characteristic;
 
 [_discoveredPeripheral setNotifyValue:YES forCharacteristic:characteristic];
 }
 //当然，你也可以监听多个characteristic特征值对象
 if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"你的特征uuid"]]){
 //同样用一个变量保存，demo里面没有声明变量，要去声明
 //            _characteristic2 = characteristic;
 //            [peripheral setNotifyValue:YES forCharacteristic:_characteristic2];
 //            NSLog(@"监听：%@",characteristic);//监听特征
 }
 }
 }
 
 
 //读
 - (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
 if (error){
 NSLog(@"Error updating value for characteristic %@ error: %@", characteristic.UUID, [error localizedDescription]);
 return;
 }
 NSLog(@"收到的数据：%@",characteristic.value);
 NSString *str = [NSString stringWithFormat:@"%@",characteristic.value];
 // 运动总包数
 if (str.length>7&&[[str substringWithRange:NSMakeRange(1, 2)]isEqualToString:@"a5"]&&[[str substringWithRange:NSMakeRange(5, 2)]isEqualToString:@"83"]) {
 //调用解析总包数方法
 [self SetAltogether:characteristic.value];
 }
 }
 
 //总包数
 - (void)SetAltogether:(NSData *)DayData{
 Byte *testByte = (Byte *)[DayData bytes];
 if (DayData.length == 6) {
 //收到数据之后，要异或校验，看数据是否完整以及正确
 if (testByte[5]==(testByte[0]^testByte[1]^testByte[2]^testByte[3]^testByte[4])){
 // 这里记录总包数
 int totalBao = 0;
 totalBao = testByte[4]*256+testByte[3];
 }
 }
 }
 **/














