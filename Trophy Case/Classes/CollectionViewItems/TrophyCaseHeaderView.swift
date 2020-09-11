//
//  TrophyCaseHeaderView.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-01.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import UIKit

class TrophyCaseHeaderView: UICollectionReusableView {
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var detailsLabel: UILabel!
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		titleLabel.text = ""
		detailsLabel.text = ""
	}
	
}
