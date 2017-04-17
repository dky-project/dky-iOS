//
//  DKYTestTableViewCell.m
//  DkyAppHD
//
//  Created by HaKim on 2017/4/17.
//  Copyright © 2017年 haKim. All rights reserved.
//

#import "DKYTestTableViewCell.h"

@implementation DKYTestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self commonInit];
}

+ (instancetype)testTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"DKYTestTableViewCell";
    DKYTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([DKYTestTableViewCell class]) owner:self options:nil].lastObject;
    }
    return cell;
}

#pragma mark - UI

- (void)commonInit{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor randomColor];
}
@end
