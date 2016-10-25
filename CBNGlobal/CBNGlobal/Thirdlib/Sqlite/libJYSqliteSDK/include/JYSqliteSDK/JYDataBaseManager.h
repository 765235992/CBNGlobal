
#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface JYDataBaseManager : NSObject
+ (instancetype)shareInstance;

/**
 *  创建数据库
 *  @param sqliteName 数据库名称(带后缀.sqlite)
 */
- (FMDatabase *)createSqliteWithSqliteName:(NSString *)sqliteName;
/**
 *  判断某一个数据库表单是否存在
 *  @param tableName 表的名称
 *  @param dataBase  数据库名
 */
- (BOOL)dataBase:(FMDatabase *)dataBase isExistTable:(NSString *)tableName;

/**
 *  给指定数据库建表
 *  @param dataBase 数据库名称
 *  @param tableName 表的名称
 *  @param keyTypes   所含字段以及对应字段类型 字典
 */
- (BOOL)dataBase:(FMDatabase *)dataBase createTable:(NSString *)tableName keyTypes:(NSDictionary *)keyTypes;

/**
 *  给指定数据库的表添加值
 *  @param dataBase 数据库名称
 *  @param keyValues 字段及对应的值
 *  @param tableName 表名称
 */
- (BOOL)dataBase:(FMDatabase *)dataBase insertKeyValues:(NSDictionary *)keyValues intoTable:(NSString *)tableName;
/**
 *  批量保存
 *  @param dataBase 数据库名称
 *  @param objectsArray 对象数组
 *  @param tableName 表名称
 */
- (BOOL)dataBase:(FMDatabase *)dataBase insertObjects:(NSArray *)objectsArray intoTable:(NSString *)tableName;

/**
 *  更新某一条数据
 *  @param dataBase 数据库名称
 *  @param keyValues 要更新字段及对应的值
 *  @param tableName 表名称
 */
- (void)dataBase:(FMDatabase *)dataBase updateTable:(NSString *)tableName setKeyValues:(NSDictionary *)keyValues;

/**
 *  查询某一个表中的所有数据
 *  @param keyTypes 查询字段以及对应字段类型 字典
 *  @param tableName 表名称
 *  @return 查询得到数据
 */
- (NSArray *)dataBase:(FMDatabase *)dataBase selectKeyTypes:(NSDictionary *)keyTypes fromTable:(NSString *)tableName;

/**
 *  清空某一个表中的所有数据
 *  @param tableName 表名称
 */
- (BOOL)dataBase:(FMDatabase *)dataBase clearTable:(NSString *)tableName;
@end
