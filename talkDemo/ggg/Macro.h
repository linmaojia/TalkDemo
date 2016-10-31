

//客户端ID
//密钥
#define ClientId @"0c73bc72abb5bed090f4e7f5bd558bfe"
#define ClientSecret @"beef7f43766ea1161ccac32e50c4a433"
#define appendStr(str1,str2) [[NSString alloc] initWithFormat:@"%@%@",str1, str2]
#define getAuthTokenPath @"/v1/oauth2/token"
//本地环境
#define LocalEnvironment
//测试环境
//#define testingEnvironment
//正式环境
//#define OfficialEnvironment
/**
 *  APIURL 服务器地址
 */

#ifdef LocalEnvironment
#define APIURL              @"http://192.168.0.37/longma"
#endif

#ifdef testingEnvironment
#define APIURL              @"http://1.linmaojia.applinzi.com"
#endif

#ifdef OfficialEnvironment
#define APIURL              @"https://ezgapi.edsmall.cn"
#endif


/*获取发布说说*/
#define APISelectTalk                      [APIURL stringByAppendingString:@"/talkCode/selectTalk.php"]
/*发布说说（没有图片）*/
#define APIInsertTalk                      [APIURL stringByAppendingString:@"/talkCode/insertTalk.php"]
/*删除说话*/
#define APIDeleteTalk                      [APIURL stringByAppendingString:@"/talkCode/deleteTalk.php"]
/*更新说说*/
#define APIUpdateTalk                      [APIURL stringByAppendingString:@"/talkCode/updateTalk.php"]

/*上传多张图片带说说*/
#define APIUploadMorePicture                      [APIURL stringByAppendingString:@"/talkCode/upload_morePicture.php"]
