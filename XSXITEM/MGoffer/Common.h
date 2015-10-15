//
       /*       公共头文件     */

#define FRAMEX(X) (X).frame.origin.x
#define FRAMEY(Y) (Y).frame.origin.y
#define FRAMEW(W) (W).frame.size.width
#define FRAMEH(H) (H).frame.size.height
  /*       清除颜色     */
#define CCCLOR  [UIColor clearColor]
  /*       浅灰颜色     */
#define GrayCLOR [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0f]
#define BLACKCLOR [UIColor blackColor]
#define REDCLOR [UIColor redColor]


 /*       创建导航    */
#define DEFINE_CONTROLLER(NAME,navigationController)\
UINavigationController *navigationController = nil;\
do {\
NAME *name = [[NAME alloc] init];\
navigationController = [[UINavigationController alloc] \
initWithRootViewController:name];\
} while(0)

#define VIEWCONTROL @"ViewControl"
#define NORMAL @"normalimage"
#define SELECT @"selectimage"
//导航栏设置方式
#define TSset(name) name.navigationBar.translucent

/*       创建image    */
#define  IMAGENAME(name)  [UIImage imageNamed:name]
#define  IMAGEDATA(data)  [UIImage imageWithData:data]
#define  URLSTRING(string) [NSURL URLWithString:string]
//粉色
#define  PINCOLOR [UIColor colorWithRed:255/255.0 green:204/255.0 blue:204/255.0 alpha:1.0f]
#define  WHITECOLOR [UIColor whiteColor]

#define BCCLOLOR(name) [UIColor colorWithPatternImage:(name)]
//设置FONT大小
#define FONT(name)  [UIFont systemFontOfSize:name]
/*       BUTTON正常状态    */
#define BTNNormal UIControlStateNormal
/*       BUTTON选中状态    */
#define BTNSelect UIControlStateSelected
/*        BUTTON按下事件    */
#define BTNTouchIN UIControlEventTouchUpInside



#define SYSTEMVERSION  [[UIDevice currentDevice] systemVersion]

#define NAVBACIMGE(name) [name.navigationBar setBackgroundImage:IMAGENAME(@"bg_navigation_default") forBarPosition:UIBarPositionTop barMetrics:UIBarMetricsDefault]

#define AIGUANGURL @"http://www.mogujie.com/app_mgj_v560_welcome/index?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=-1&_swidth=640&_saveMode=0&_mgj=87670ebe3fb7365a353e0e21ec3a1c3e1402305398"

#define AIGOUJXPULLREFRESH @"http://www.mogujie.com/app_mgj_v560_book/fashion?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=2&_swidth=640&_saveMode=0&_mgj="

#define AGJXBOOK @"&mbook=eyJwYWdlIjozfQ%3D%3D"

#define JXONEPAGE @"46d7a15dfe53f9422cd03c5123233b031404638902"

//#define FENLEIURL @"http://www.mogujie.com/app_mgj_v560_book/categories?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=2&_swidth=640&_saveMode=0&_mgj=75b1ec0dd9cb7e5fcdf0e0d8e8ac8c0d1402365197"

//发现视图URL
#define FindViewURL @"http://www.mogujie.com/app_mgj_v560_welcome/discover?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=b630a5d8cc73a05df7f34819319703871402307244&"

#define DARENURL @"http://www.mogujie.com/app_mgj_v560_photo/darenstyle?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=43641cb0ff39a14c355bf7e9682d25341402307766&"




//榜单视图URL

#define BanDanURL @"http://www.mogujie.com/app_mgj_v560_book/rank?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=ec9bc1d0fe7df6354fdc592301eb0afc1402307444&"
//团购视图URL

#define TuanGouURL @"http://www.mogujie.com/app_mgj_v560_tuan/list?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=7b6e3024db28476546b9a2860e7104e61402307573&"

/*分类视图控制器URL*/

#define FENLEIURL @"http://www.mogujie.com/app_mgj_v560_book/categories?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=2&_swidth=640&_saveMode=0&_mgj=75b1ec0dd9cb7e5fcdf0e0d8e8ac8c0d1402365197"


/*达人视图控制器URL*/

#define DRURL(num) @"http://www.mogujie.com/app_mgj_v560_photo/darenstyle?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=num&"

//搭配达人URL
#define DRDPNUM  43641cb0ff39a14c355bf7e9682d25341402307766



//晒货达人URL
#define DRSHDRNUM 77724a1869ce67d87b8afc20e9aec6771402307914

//明星达人URL
#define DRMXDRNUM  3259f7d591ec0d2ac651c304ae1cc74e1402308030

#define DRDPURL @"http://www.mogujie.com/app_mgj_v560_photo/darenstyle?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=43641cb0ff39a14c355bf7e9682d25341402307766&"

#define DRSHDRURL @"http://www.mogujie.com/app_mgj_v560_photo/qiaodastyle?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=77724a1869ce67d87b8afc20e9aec6771402307914&"

#define DRMXURL @"http://www.mogujie.com/app_mgj_v560_photo/starstyle?_channel=NIMAppStore&_adid=AD047926-6358-4471-B38E-A350EC11153C&_did=8534439b74c50c4d97d4e669cf67e6a3&_atype=iPhone&_source=NIMAppStore560&_aver=560&_fs=NIMAppStore560&_network=0&_swidth=640&_saveMode=0&_mgj=3259f7d591ec0d2ac651c304ae1cc74e1402308030&"

