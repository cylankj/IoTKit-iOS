//
//  CylanJFGSDK.h
//  JFGSDK
//
//  Created by yangli on 16/9/30.
//  Copyright © 2016年 yangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JFGErrorType.h"

@interface CylanJFGSDK : NSObject

#pragma mark- 摄像头相关
+(void)connectCamera:(NSString *)cid;
+(void)playVideoByTime:(int64_t)time cid:(NSString *)cid;
+(void)startRenderRemoteView:(UIView *)view;
+(BOOL)openLocalCamera:(BOOL)front;
+(void)startRenderLocalView:(UIView *)view;
+(void)stopRenderView:(BOOL)local withCid:(NSString *)cid;
+(void)disconnectVideo:(NSString *)remote;

+(UIImage *)imageForSnapshot;
+(void)getHistoryVideoListForCid:(NSString *)cid;
+(void)getHistoryVideoListV2:(NSString *)cid
                   searchWay:(int)searchWay
                   timeEnd:(int)timeEnd
                 searchRange:(int)range;
+(void)setAudio:(BOOL)local openMic:(BOOL)openMic openSpeaker:(BOOL)openSpeaker;
+(void)switchLiveVideo:(BOOL)isLive beigenTime:(int64_t)beigenTime;

/**
 * @brief  设置喇叭增益
 * @param  level: 喇叭倍数,值为0.0-10.0之间,10.0为最大,默认是1.0
 * return  #JFGErrorTypeNone 表示成功, 其他情况下可能是范围出错
 * @note   值越小增益越大
 */
+(JFGErrorType)setTargetLeveledBFS:(int)level;

/**
 * @brief  设置麦克风增益
 * @param  level: 值为0-31之间,0为最大,默认是8
 * return  #JFGErrorTypeNone 表示成功, 其他情况下可能是范围出错
 * @note   值越小增益越大
 */
+(JFGErrorType)setDefaultOutputVolumeScale:(float)scale;

@end
