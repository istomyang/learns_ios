//
//  LISCNetworkCheck.m
//  learns_ios
//
//  Created by 杨洋 on 24/5/2022.
//

#import "LISCNetworkCheck.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>
#import <UIkit/UIkit.h>

/*
 
 https://developer.apple.com/library/archive/samplecode/SimplePing/Introduction/Intro.html#//apple_ref/doc/uid/DTS10000716-Intro-DontLinkElementID_2
 
 https://www.jianshu.com/p/49220fed0118
 
 https://developer.apple.com/library/archive/samplecode/Reachability/Introduction/Intro.html
 
 
 */

@implementation LISCNetworkCheck

SCNetworkConnectionFlags connectionFlags;
SCNetworkReachabilityRef reachability;

+ (void)pingReachability
{
    SCNetworkReachabilityRef reachability;
    
    BOOL ignoresAdHocWiFi = NO;
    
    // 服务器地址，用来保存服务器的地址信息（该结构体专门保存IPV4地址），包括ip和端口
    struct sockaddr_in address;
    
    // 清零
    // The IEEE Standard doesn't require it.
    // But, it's best to be safe and zero out everything.
    // 因为 in sockaddr_in6 here:
    // The sockaddr_in6 structure shall be set to zero by an application prior to using it,
    // since implementations are free to have additional, implementation-defined fields in sockaddr_in6.
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    
    // 指定协议族为网际协议族
    address.sin_family = AF_INET;
    
    // INADDR_ANY：0.0.0.0
    // IN_LINKLOCALNETNUM：网卡分配IP失败的情况下，系统设置的IP地址
    address.sin_addr.s_addr = htonl(ignoresAdHocWiFi ? INADDR_ANY : IN_LINKLOCALNETNUM);
    
    // Creates a reachability reference to the specified network address.
    reachability = SCNetworkReachabilityCreateWithAddress(
                                                          kCFAllocatorDefault,
                                                          (struct sockaddr *)&address);
    
    
    // Recover reachability flags
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(reachability, &connectionFlags);
    if (!didRetrieveFlags) printf("Error. Could not recover network reachability flags\n");
}

+ (BOOL)networkAvailable
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self pingReachability];
    BOOL isReachable = ((connectionFlags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((connectionFlags & kSCNetworkFlagsConnectionRequired) != 0);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
