//
//  IMAlbumListViewCell.m
//  AlbumBrowse
//
//  Created by Chentao on 15/4/29.
//  Copyright (c) 2015年 Chentao. All rights reserved.
//

#import "IMAlbumListViewCell.h"


@interface IMAlbumListViewCell ()

@property (nonatomic, strong) UIImageView *albumCoverImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *photoCountLabel;
@property (nonatomic, strong) UIImageView *detailIcon;

@end

@implementation IMAlbumListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		//self.selectionStyle = UITableViewCellSelectionStyleNone;

		self.backgroundColor = [UIColor clearColor];
		_albumCoverImage = [[UIImageView alloc]init];
		[self.contentView addSubview:_albumCoverImage];

		_titleLabel = [[UILabel alloc]init];
		_titleLabel.font = [UIFont systemFontOfSize:16];
		[self.contentView addSubview:_titleLabel];

		_photoCountLabel = [[UILabel alloc]init];
		_photoCountLabel.font = [UIFont systemFontOfSize:16];
		_photoCountLabel.textColor = [UIColor grayColor];
		[self.contentView addSubview:_photoCountLabel];


		_detailIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test.jpg"]];
		_detailIcon.frame = CGRectMake(0, 0, 25, 25);
		[self.contentView addSubview:_detailIcon];
	}
	return self;
}

- (void)setCellData:(IMAssetsGroup *)cellData {
	_cellData = cellData;
	_albumCoverImage.image = cellData.cover;
	_titleLabel.text = cellData.name;
	_photoCountLabel.text = [NSString stringWithFormat:@"（%@）", @(cellData.count)];
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	[super layoutSubviews];

	CGFloat padding = 5.0;
	_albumCoverImage.frame = CGRectMake(padding, padding, IMAlbumListViewCellHeight - 2 * padding, IMAlbumListViewCellHeight - 2 * padding);

	CGSize titleLabelSize = [_titleLabel.text sizeWithFont:_titleLabel.font];
	CGFloat titleLabelX = _albumCoverImage.frame.origin.x + _albumCoverImage.frame.size.width + 10;
	CGFloat titleLabelY = 0.5 * (self.bounds.size.height - titleLabelSize.height);
	_titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelSize.width, titleLabelSize.height);


	CGSize photoCountLabelSize = [_photoCountLabel.text sizeWithFont:_photoCountLabel.font];
	CGFloat photoCountLabelX = titleLabelX + titleLabelSize.width + 10;
	CGFloat photoCountLabelY = 0.5 * (self.bounds.size.height - photoCountLabelSize.height);
	_photoCountLabel.frame = CGRectMake(photoCountLabelX, photoCountLabelY, photoCountLabelSize.width, photoCountLabelSize.height);

	CGFloat detailIconX = self.bounds.size.width - _detailIcon.frame.size.width - 10;
	CGFloat detailIconY = 0.5 * (self.bounds.size.height - _detailIcon.frame.size.height);


	_detailIcon.frame = CGRectMake(detailIconX, detailIconY, _detailIcon.frame.size.width, _detailIcon.frame.size.height);
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}

@end
