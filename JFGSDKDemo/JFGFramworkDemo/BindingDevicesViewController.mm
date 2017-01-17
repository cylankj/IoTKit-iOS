///
//  BindingDevicesViewController.m
//  JFGFramworkDemo
//
//  Created by yangli on 16/4/5.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import "BindingDevicesViewController.h"
#import <JFGSDK/JFGSDK.h>
#import "VideoViewController.h"
#import "DoorCallViewController.h"
#import "AddDeviceViewController.h"
#import <JFGSDK/JFGSDKDataPoint.h>
#import "PanoramicCameraViewController.h"
#import <JFGSDK/JFGSDKBindingDevice.h>
#import "GetBluetoothEquipmentNearby.h"
//#import <JFGSDK/JFGSDKEfamilyMsgpack.h>

//200000149340
@interface BindingDevicesViewController ()<JFGSDKCallbackDelegate,JFGSDKBindDeviceDelegate,UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate>
{
    NSMutableData *_recieveDat;
    JFGSDKBindingDevice *bindDevice;
    GetBluetoothEquipmentNearby *bluetoorh;
    NSTimer *_timer;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIBarButtonItem *rightBarItem;
@property (nonatomic,strong)UIBarButtonItem *leftBarItem;

@end

@implementation BindingDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Device that has been bound";
    self.view.backgroundColor = [UIColor whiteColor];
   
    [JFGSDK addDelegate:self];
    
    //添加设备按钮
    self.navigationItem.rightBarButtonItem = self.rightBarItem;
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;

    //设备列表视图
    [self.view addSubview:self.tableView];
    
    
    /**
     
     msgpack 数据打包
     NSString *sourceStr = @"msgpack pack test";
     NSData *msgPackData = [MPMessagePackWriter writeObject:sourceStr error:nil];
     
     */
//    DataPointIDVerSeg *seg = [[DataPointIDVerSeg alloc]init];
//    seg.msgId = 507;
//    seg.version = 0;
    
//    DataPointSeg *setSeg = [[DataPointSeg alloc]init];
//    setSeg.msgId = 215;
//    setSeg.value = [MPMessagePackWriter writeObject:[NSNumber numberWithBool:YES] error:nil];
//    setSeg.version = 0;
//    
//   [[JFGSDKDataPoint sharedClient] robotSetDataWithPeer:@"200000149340" dps:@[setSeg] success:^(NSArray<DataPointIDVerRetSeg *> *dataList) {
//       NSLog(@"%@",dataList);
//   } failure:^(RobotDataRequestErrorType type) {
//       
//   }];


   // [JFGSDK fping:@"255.255.255.255"];

    //[JFGSDK ping:@"255.255.255.255"];
   // [JFGSDK setPassword:@"111111" forType:0 smsToken:@"25423"];
    
    
    [self getAccountHeadImage];
}

-(void)jfgSetPasswordForOpenLoginResult:(JFGErrorType)errorType
{
    
}

-(void)jfgPingRespose:(JFGSDKUDPResposePing *)ask
{
    NSLog(@"%@",[ask description]);
    if ([ask.cid containsString:@"500000001298"]) {
        
        [JFGSDK deviceUpgreadeForIp:ask.address upgradeFileUrl:@"/Documents/jfg.h"];
        
    }
}

-(void)jfgFpingRespose:(JFGSDKUDPResposeFping *)ask
{
    NSLog(@"%@",[ask description]);
    if ([ask.cid containsString:@"500000001298"]) {
        
        [JFGSDK deviceUpgreadeForIp:ask.address upgradeFileUrl:@""];
        
    }
}

-(void)jfgDevUpgradeInfo:(JFGSDKDeviceUpgrade *)info
{
    
}

-(void)jfgRobotPushMsgForPeer:(NSString *)peer msgList:(NSArray<NSArray<DataPointSeg *> *> *)msgList
{
    
}


-(void)jfgRobotSyncDataForPeer:(NSString *)peer fromDev:(BOOL)isDev msgList:(NSArray<DataPointSeg *> *)msgList
{
    for (DataPointSeg *seg in msgList) {
        
        id obj = [MPMessagePackReader readData:seg.value error:nil];
        NSLog(@"peer:%@ fromDev:%d  msgID:%llu",peer,isDev,seg.msgId);
        NSLog(@"value:%@",[obj description]);
        
    }
}


-(void)jfgEfamilyMsg:(id)msg
{
    
}


-(void)logout
{
    [JFGSDK logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//class MsgClientMagListReq : public MsgHeader{
//public:
//    MSGPACK_DEFINE(mId, mCaller, mCallee,mSeq,timeBegin, timeEnd);
//    MsgClientMagListReq() : MsgHeader(1092){
//        
//        init();
//    }
//    void init()
//    {
//        timeBegin = 0;
//        timeEnd = 0;
//    }
//    int64_t timeBegin;
//    int64_t timeEnd;
//};
//
//class MsgClientmsgReq : public MsgHeader{
//public:
//    MSGPACK_DEFINE(mId, mCaller, mCallee,mSeq,timeBegin, content);
//    MsgClientmsgReq() : MsgHeader(1092){
//        
//        init();
//    }
//    void init()
//    {
//        timeBegin = 0;
//        content = "";
//    }
//    int64_t timeBegin;
//    std::string content;
//};


-(void)viewDidAppear:(BOOL)animated
{
    
    //发送中控消息示例代码，勿删
//    MsgHeader msgHeader;
//    msgHeader.mId = 1092;
//    msgHeader.mCaller = "";
//    msgHeader.mCallee = "730000000496";
//    
//    std::string head = getBuff(msgHeader);
//    
//    NSData *data = [NSData dataWithBytes:head.c_str() length:head.length()];
//    
//    [JFGSDK sendEfamilyMsgData:data];
    
    
//    long long timeEnd = [[NSDate date] timeIntervalSince1970];
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1092], @"mId",@(timeEnd),@"timeEnd",@"730000000496",@"cid", nil];
//    
//    MsgClientmsgReq req;
//    req.mId = 15009;
//    req.mCallee = "730000000496";
//    req.mCaller = "";
//    req.timeBegin = 0;
//    std::string reqData = getBuff(req);
//    
//   
//    
//    NSData *data = [NSData dataWithBytes:reqData.c_str() length:reqData.length()];
//    [JFGSDK sendEfamilyMsgData:data];
    
    
  
//    int64_t time = [[NSDate date] timeIntervalSince1970];
//    //[JFGSDK sendFeedbackWithTimestamp:time content:@"反馈测试" hasSendLog:NO];
//    //[JFGSDK getFeedbackList];
//   
//    
//    UIImage *image = [UIImage imageNamed:@"cardImage"];
//    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    path = [path stringByAppendingPathComponent:@"account.png"];
//    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:path atomically:YES];
    
    //http://yf.jfgou.com:443/index.php?mod=client&act=photo
    ///index.php?mod=client&act=set_photo
//    int requestID = [JFGSDK httpPostWithReqPath:@"/index.php?mod=client&act=set_photo" filePath:path];
//    NSLog(@"requestID:%d",requestID);
    
   // int requestID = [JFGSDK httpGetWithReqPath:@"http://yf.jfgou.com:80/index.php?mod=client&act=photo&sessid=xxxxxxx"];
//    NSLog(@"requestID:%d",requestID);
//    
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://yf.jfgou.com:443/index.php?mod=client&act=photo"]];
//    UIImage *Image = [[UIImage alloc]initWithData:imageData];
//   
   // [JFGSDK getCloudUrlWithFlag:1 fileName:@"http://yf.jfgou.com/index.php?mod=client&act=photo"];
    
    
    //[JFGSDK getFeedbackList];
    
    
}




-(void)jfgDevVersionUpgradInfo:(JFGSDKDeviceVersionInfo *)info
{
    
}


-(void)jfgUpdateAccount:(JFGSDKAcount *)account
{
    NSLog(@"%@",account.headUrl);
}

-(void)jfgHttpResposeRet:(int)ret requestID:(int)requestID result:(NSString *)result
{
     NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
     NSLog(@"%@",dict.description);
}


-(void)jfgForgetPassByEmail:(NSString *)email errorType:(JFGErrorType)errorType
{
    
}

-(NSArray *)getWaringPicForSourceData:(NSArray *)srcArr byCid:(NSString *)cid
{
    NSMutableArray *picUrl = [NSMutableArray new];
    NSString *fristPic = nil;
    NSString *secondPic = nil;
    NSString *thirdPic = nil;
    
    if ([srcArr isKindOfClass:[NSArray class]]) {
        
        if (srcArr.count>3) {
            
            int64_t time = [srcArr[0] intValue];
            int file = [srcArr[2] intValue];
            int flag = [srcArr[3] intValue];

            
            switch (file) {
                case 0: //000
                    return picUrl;
                    break;
                case 1: //001  第一张
                    fristPic = [self getCloudUrlForCid:cid timestamp:time order:1 flag:flag];
                    break;
                case 2: //010
                    secondPic = [self getCloudUrlForCid:cid timestamp:time order:2 flag:flag];
                    break;
                case 3: {//011
                    fristPic = [self getCloudUrlForCid:cid timestamp:time order:1 flag:flag];
                    secondPic = [self getCloudUrlForCid:cid timestamp:time order:2 flag:flag];
                }
                    break;
                case 4: //100
                    thirdPic = [self getCloudUrlForCid:cid timestamp:time order:3 flag:flag];
                    break;
                case 5: {//101
                    thirdPic = [self getCloudUrlForCid:cid timestamp:time order:3 flag:flag];
                    fristPic = [self getCloudUrlForCid:cid timestamp:time order:1 flag:flag];
                }
                    break;
                case 6: {//110
                    thirdPic = [self getCloudUrlForCid:cid timestamp:time order:3 flag:flag];
                    secondPic = [self getCloudUrlForCid:cid timestamp:time order:2 flag:flag];
                }
                    break;
                case 7: {//111
                    thirdPic = [self getCloudUrlForCid:cid timestamp:time order:3 flag:flag];
                    secondPic = [self getCloudUrlForCid:cid timestamp:time order:2 flag:flag];
                    fristPic = [self getCloudUrlForCid:cid timestamp:time order:1 flag:flag];
                }
                    break;
                default:
                    break;
            }
            
        }
        
    }
    
    if (fristPic) {
        [picUrl addObject:fristPic];
    }
    
    if (secondPic) {
        [picUrl addObject:secondPic];
    }
    
    if (thirdPic) {
        [picUrl addObject:thirdPic];
    }
    
    return picUrl;
}

-(NSString *)getCloudUrlForCid:(NSString *)cid timestamp:(uint64_t)timestamp order:(int)order flag:(int)flag
{
    return [JFGSDK getCloudUrlByType:JFGSDKGetCloudUrlTypeWarning flag:flag fileName:[NSString stringWithFormat:@"%lld_%d.jpg",timestamp,order] cid:cid];
}

-(void)jfgDeviceShareList:(NSDictionary<NSString *,NSArray<JFGSDKFriendRequestInfo *> *> *)friendList
{
    NSLog(@"%@",[friendList description]);
    for (NSString *key in friendList.allKeys) {
        
        NSArray *subArr = friendList[key];
        for (JFGSDKFriendInfo *info in subArr) {
            
            NSLog(@"%@",info.account);
        }
        
    }
}



//添加设备
-(void)addDeviceAction
{
    AddDeviceViewController *add = [AddDeviceViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:add];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)jfgDeviceList:(NSArray<JFGSDKDevice *> *)deviceList
{
    _deviceList = [[NSMutableArray alloc]initWithArray:deviceList];
    [_tableView reloadData];
    NSLog(@"设备列表更新");
}


#pragma mark- tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceList.count+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *_cell = [tableView dequeueReusableCellWithIdentifier:@"dingCellID"];
    if (_cell == nil) {
        _cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"dingCellID"];
    }
    if (indexPath.row >= self.deviceList.count) {
        _cell.textLabel.text = @"test";
        return _cell;
    }
    id obj = self.deviceList[indexPath.row];
    if ([obj isKindOfClass:[JFGSDKDevice class]]) {
        JFGSDKDevice *message = obj;
        
        if (message.alias && ![message.alias isEqualToString:@""]) {
            
            _cell.textLabel.text = message.alias;
            
        }else{
            
            _cell.textLabel.text = message.uuid;
        }
    }
    return  _cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.deviceList.count) {
        
//        [self didSelectedCellLast];
        //门铃
        VideoViewController *video = [VideoViewController new];
        video._cid = @"680000000030";
        [self.navigationController pushViewController:video animated:YES];
        return;
    }
    
    
    JFGSDKDevice *message = self.deviceList[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch ([message.pid intValue]) {
        case 4:
        case 5:
        case 7:
        case 13:{
            
            //摄像头
            VideoViewController *video = [VideoViewController new];
            
            //VideoTestViewController *video = [VideoTestViewController new];
            
            video._cid = message.uuid;
            [self.navigationController pushViewController:video animated:YES];
            
        }
            break;
        case 6:
        case 14:
        case 15:{
            //门铃
            VideoViewController *video = [VideoViewController new];
            video._cid = message.uuid;
            [self.navigationController pushViewController:video animated:YES];
        }
            break;
        case 11:{
            //门磁
        }
            break;
        case 8:{
            //中控
        }
            break;
            
        case 18:
        case 19:
        case 86:{
            PanoramicCameraViewController *pan = [PanoramicCameraViewController new];
            pan.cid = message.uuid;
            [self.navigationController pushViewController:pan animated:YES];
        }
            break;
        default:
            break;
    }

}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        //        获取选中删除行索引值
        NSInteger row = [indexPath row];
        //        通过获取的索引值删除数组中的值
        
        JFGSDKDevice *message = self.deviceList[row];
        
        //解除绑定
        [JFGSDK unBindDev:message.uuid];
        
        [self.deviceList removeObjectAtIndex:row];
        
        //        删除单元格的某一行时，在用动画效果实现删除过程
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }  
}

#pragma mark- getter

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

-(UIBarButtonItem *)rightBarItem
{
    if (!_rightBarItem) {
        _rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStyleDone target:self action:@selector(addDeviceAction)];
    }
    return _rightBarItem;
}

-(UIBarButtonItem *)leftBarItem
{
    if (!_leftBarItem) {
        _leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    }
    return _leftBarItem;
}

-(void)setDeviceList:(NSMutableArray *)deviceList
{
    _deviceList = [deviceList mutableCopy];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}
- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark- 意见反馈测试
-(void)didSelectedCellLast
{

    [JFGSDK appendStringToLogFile:@"haha"];

}

-(void)jfgChangerPasswordResult:(JFGErrorType)errorType
{
    
}

/*!
 *  收到萝卜头透传的消息
 */
-(void)jfgOnRobotTransmitMsg:(JFGSDKRobotMessage *)message
{
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"收到透传回调" message: [NSString stringWithFormat:@"sn:%d  caller:%@",message.sn,message.caller] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aler show];
}

/*!
 *  萝卜头消息应答
 *
 *  @param sn 消息序列号
 */
-(void)jfgOnRobotMsgAck:(int)sn
{
   
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"收到透传回调" message: [NSString stringWithFormat:@"sn:%d",sn] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [aler show];
}

//未读消息反馈列表
-(void)jfgFeedBackWithInfoList:(NSArray<JFGSDKFeedBackInfo *> *)infoList errorType:(JFGErrorType)errorType
{
    for (JFGSDKFeedBackInfo *info in infoList) {
        NSLog(@"%lld :%@",info.timestamp,info.msg);
    }
}

-(void)uplodHeadImage
{
    NSString *sourceUrl = [[NSBundle mainBundle] pathForResource:@"catPic" ofType:@"jpg"];
    UIImage *image = [UIImage imageWithContentsOfFile:sourceUrl];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
    
    NSString *loadUrl = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    loadUrl = [loadUrl stringByAppendingPathComponent:@"head.jpg"];
    [imageData writeToFile:loadUrl atomically:YES];
    
    [JFGSDK uploadFile:loadUrl toCloudFolderPath:@"/image/18503060168.jpg" requestId:1523];
    
    NSLog(@"imageSize:%d",imageData.length);
    
}



#pragma mark- 头像测试
-(void)getAccountHeadImage
{
    //[JFGSDK getCloudUrlWithFlag:0 fileName:@"/image/18503060168.jpg"];
     NSString *h =[JFGSDK getCloudUrlByType:JFGSDKGetCloudUrlTypeUserHead flag:0 fileName:@"18503060168.jpg" cid:nil];
    NSLog(@"%@",h);
}

-(void)jfgUploadDeviceTokenResult:(JFGErrorType)errorType
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 
 MsgHeader msgHeader;
 msgHeader.mId = 4202;
 msgHeader.mCaller = "";
 msgHeader.mCallee = "70000000498";
 
 std::string head = getBuff(msgHeader);
 
 NSData *data = [NSData dataWithBytes:head.c_str() length:head.length()];
 
 [JFGSDK sendEfamilyMsgData:data];
 
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
