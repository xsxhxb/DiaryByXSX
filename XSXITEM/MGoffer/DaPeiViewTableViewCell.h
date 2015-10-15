

#import <UIKit/UIKit.h>
#import "AGListCellModel.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface DaPeiViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TagLaber;
@property (weak, nonatomic) IBOutlet UIImageView *Headimageiview;
@property (weak, nonatomic) IBOutlet UIImageView *Personimageview;
@property (weak, nonatomic) IBOutlet UILabel *Personnamelaber;
@property (weak, nonatomic) IBOutlet UILabel *ShopDetaillaber;
@property (weak, nonatomic) IBOutlet UIImageView *CDimageview;
@property (weak, nonatomic) IBOutlet UILabel *CDlaber;
@property (weak, nonatomic) IBOutlet UIImageView *Favimageview;
@property (weak, nonatomic) IBOutlet UILabel *Favlaber;
@property (weak, nonatomic) IBOutlet UIImageView *Sepatateimageview;

@property(nonatomic ,strong) AGListCellModel *model;

@end
