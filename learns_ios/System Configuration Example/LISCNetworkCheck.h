//
//  LISCNetworkCheck.h
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import <Foundation/Foundation.h>


/*
 
 + 如果App提供下载之前不检测网络状态，苹果会拒绝上架。
 + 如果下载，需要提供相应的警示信息。
 + 苹果会拒绝大量消耗数据流量的App。
 + 数据流量应该提供低品质的数据流，Wifi提供高品质的数据流。
 
 
 */

NS_ASSUME_NONNULL_BEGIN

@interface LISCNetworkCheck : NSObject

@end

NS_ASSUME_NONNULL_END
