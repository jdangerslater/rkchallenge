//
//  TrophyCell.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-01.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import UIKit

class TrophyCell: UICollectionViewCell {
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var raceDetailsLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		imageView.layer.shadowColor = UIColor(fromInt: 0x333333).cgColor
		imageView.layer.shadowOpacity = 0.4
		imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
		imageView.layer.shadowRadius = 5
		imageView.clipsToBounds = false
		
		imageView.layer.rasterizationScale = UIScreen.main.nativeScale
	}
	
	override func prepareForReuse() {
		imageView.layer.shouldRasterize = false
	}
	
	func setTrophyImage(_ image: UIImage?) {
		imageView.image = image
		imageView.layer.shouldRasterize = true
	}
}
