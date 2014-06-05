
#import <UIKit/UIKit.h>

@interface Cell1 : UITableViewCell


@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet UIImageView *arrowImageView;

- (void)changeArrowWithUp:(BOOL)up;
@end
