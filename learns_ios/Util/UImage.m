//
//  UImage.m
//  learns_ios
//
//  Created by 杨洋 on 17/5/2022.
//

#import "UImage.h"
#import "UGeometry.h"

/// 创建缩略图
UIImage *U_ImageBuildThumbnail(UIImage *sourceImage, CGSize targetSize, BOOL useFitting)
{
    CGRect targetRect = U_MakeRectSize(targetSize);
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, 0.0);

    CGRect naturalRect = U_MakeRectSize(sourceImage.size);
    CGRect destinationRect = useFitting
                            ? U_MakeRectByFitting(naturalRect, targetRect)
                            : U_MakeRectByFilling(naturalRect, targetRect);
    
    [sourceImage drawInRect:destinationRect];
    
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

/// 大框框，小框框，以Insets的形式返回间隔。
UIEdgeInsets BuildInsets(CGRect alignmentRect, CGRect imageBounds)
{
    // Ensure alignment rect is fully within source
    CGRect targetRect = CGRectIntersection(alignmentRect, imageBounds);
    
    // Calculate insets
    UIEdgeInsets insets;
    insets.left = CGRectGetMinX(targetRect) - CGRectGetMinX(imageBounds);
    insets.right = CGRectGetMaxX(imageBounds) - CGRectGetMaxX(targetRect);
    insets.top = CGRectGetMinY(targetRect) - CGRectGetMinY(imageBounds);
    insets.bottom = CGRectGetMaxY(imageBounds) - CGRectGetMaxY(targetRect);
    
    return insets;
}

