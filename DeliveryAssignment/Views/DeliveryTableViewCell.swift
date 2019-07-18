//
//  DeliveryTableViewCell.swift
//   Delivery Assignment
//
//  Created by Arpit Tripathi on 04/07/19.
//  Copyright © 2019 Arpit Tripathi. All rights reserved.
//

import UIKit
import SDWebImage
class DeliveryTableViewCell: UITableViewCell {
  
  let img = UIImageView()
  let message = UILabel()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.backgroundColor = UIColor.white
    img.backgroundColor = UIColor.lightGray
    img.contentMode = .scaleAspectFill
    img.translatesAutoresizingMaskIntoConstraints = false
    message.translatesAutoresizingMaskIntoConstraints = false
    message.font = UIFont.systemFont(ofSize: TableViewConstants.labelFontSize)
    message.numberOfLines = 0
    contentView.layer.borderColor = UIColor.darkGray.cgColor
    contentView.layer.borderWidth = TableViewConstants.cellBorderWidth
    contentView.addSubview(img)
    contentView.addSubview(message)
    
    let viewsDict = [
      "image": img,
      "message": message
    ]
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image(80)]", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[image]-10-[message]-10-|", options: [], metrics: nil, views: viewsDict))
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    
    contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[image(80)]", options: [], metrics: nil, views: viewsDict))
    
    let bottomSpaceToLabelConstraint = NSLayoutConstraint.init(item: contentView, attribute: .bottomMargin, relatedBy: .greaterThanOrEqual, toItem: img, attribute: .bottomMargin, multiplier: 1, constant: 10)
    self.contentView.addConstraint(bottomSpaceToLabelConstraint)
    
    img.layer.cornerRadius = TableViewConstants.imageCornerRadius
    img.layer.masksToBounds = true
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setData(model: DeliveryObject) {
    self.message.text = (model.descriptionField ?? "") + LocalizedKeys.appendedStringAt + (model.location?.address ?? "")
    self.img.sd_imageIndicator = SDWebImageActivityIndicator.gray
    if let imgURL = model.imageUrl {
      self.img.sd_setImage(with: URL(string: imgURL), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.continueInBackground, context: nil)
    }
  }
}
