//
//  TRComposeTool.m
//  微博
//
//  Created by Tory on 15/11/11.
//  Copyright © 2015年 normcore. All rights reserved.
//

#import "TRComposeTool.h"
#import "TRHttpTool.h"
#import "TRComposeParam.h"
#import "MJExtension.h"

#import "TRUploadParam.h"

#import "AFNetworking.h"

@implementation TRComposeTool
+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    TRComposeParam *param = [TRComposeParam param];
    param.status = status;
    
    [TRHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //  创建参数模型
    TRComposeParam *param = [TRComposeParam param];
    param.status = status;
    
    //  创建上传的模型
    TRUploadParam *uplodaP = [[TRUploadParam alloc] init];
    uplodaP.data = UIImagePNGRepresentation(image);
    uplodaP.name = @"pic";
    uplodaP.filename = @"image.png";
    uplodaP.mimeType = @"image/png";
    
    //  注意：以后如果是一个方法，要传很多参数，就把参数包装成一个模型
    [TRHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uplodaP success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
