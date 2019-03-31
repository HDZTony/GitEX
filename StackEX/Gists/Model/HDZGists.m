#import "HDZGists.h"
#import "YYModel.h"
#import "HDZOwner.h"
#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface HDZGist (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface HDZFiles (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end



static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

HDZGists *_Nullable HDZGistsFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : map(json, λ(id x, [HDZGist fromJSONDictionary:x]));
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

HDZGists *_Nullable HDZGistsFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return HDZGistsFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable HDZGistsToData(HDZGists *gists, NSError **error)
{
    @try {
        id json = map(gists,  λ(id x, [x JSONDictionary]));
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable HDZGistsToJSON(HDZGists *gists, NSStringEncoding encoding, NSError **error)
{
    NSData *data = HDZGistsToData(gists, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation HDZGist
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"forksURL":@"forks_url",
             @"identifier":@"id",
             @"nodeID":@"node_id",
             @"gitPullURL": @"git_pull_url",
             @"gitPushURL": @"git_push_url",
             @"htmlURL": @"html_url",
             @"isPublic": @"public",
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
             @"theDescription": @"description",
             @"commentsURL": @"comments_url",
             @"isTruncated": @"truncated",
             };
}
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
                                                    @"url": @"url",
                                                    @"forks_url": @"forksURL",
                                                    @"commits_url": @"commitsURL",
                                                    @"id": @"identifier",
                                                    @"node_id": @"nodeID",
                                                    @"git_pull_url": @"gitPullURL",
                                                    @"git_push_url": @"gitPushURL",
                                                    @"html_url": @"htmlURL",
                                                    @"files": @"files",
                                                    @"public": @"isPublic",
                                                    @"created_at": @"createdAt",
                                                    @"updated_at": @"updatedAt",
                                                    @"description": @"theDescription",
                                                    @"comments": @"comments",
                                                    @"user": @"user",
                                                    @"comments_url": @"commentsURL",
                                                    @"owner": @"owner",
                                                    @"truncated": @"isTruncated",
                                                    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HDZGist alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _files = [HDZFiles fromJSONDictionary:(id)_files];
        _owner = [HDZOwner fromJSONDictionary:(id)_owner];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HDZGist.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HDZGist.properties.allValues] mutableCopy];
    
    for (id jsonName in HDZGist.properties) {
        id propertyName = HDZGist.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }
    
    [dict addEntriesFromDictionary:@{
                                     @"files": [_files JSONDictionary],
                                     @"public": _isPublic ? @YES : @NO,
                                     @"owner": [_owner JSONDictionary],
                                     @"truncated": _isTruncated ? @YES : @NO,
                                     }];
    
    return dict;
}
@end

@implementation HDZFiles
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{
             @"rawURL": @"raw_url",
             };
}
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
                                                    @"filename": @"filename",
                                                    @"type": @"type",
                                                    @"language": @"language",
                                                    @"raw_url": @"rawURL",
                                                    @"size": @"size",
                                                    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[HDZFiles alloc] initWithJSONDictionary:dict] : nil;
}


- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = HDZFiles.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:HDZFiles.properties.allValues] mutableCopy];
    
    for (id jsonName in HDZFiles.properties) {
        id propertyName = HDZFiles.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }
    
    return dict;
}

@end


NS_ASSUME_NONNULL_END

