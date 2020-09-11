//
//  TrophyCaseFlowLayout.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-03.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import UIKit

class TrophyCaseFlowLayout: UICollectionViewFlowLayout {
	
	let leftColumnX: CGFloat = 16
	let rightColumnX = UIScreen.main.bounds.width / 2 + 8
	let itemWidth = UIScreen.main.bounds.width / 2 - 24
	let itemHeights: [CGFloat] = [179, 228]
	
	lazy var dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
	
	override init() {
		super.init()
		
		minimumLineSpacing = 16
		minimumInteritemSpacing = 16
		estimatedItemSize = CGSize(width: itemWidth, height: itemHeights[0])
		sectionInset = UIEdgeInsets(top: 32, left: 16, bottom: 32, right: 16)
		headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 48)
		sectionHeadersPinToVisibleBounds = true
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	// Attempted to use UIDynamicAnimator to give contents some gravity while scrolling
	/*override func prepare() {
		super.prepare()
		
		if let collectionView = collectionView {
			let size = collectionView.contentSize
			if let items = layoutAttributesForElements(in: CGRect(origin: .zero, size: size)) {
				if dynamicAnimator.behaviors.count == 0 {
					for item in items {
						let behaviour = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
						
						behaviour.length = 0
						behaviour.damping = 0.8
						behaviour.frequency = 1
						
						dynamicAnimator.addBehavior(behaviour)
					}
				}
			}
		}
	}
	
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return dynamicAnimator.items(in: rect) as? [UICollectionViewLayoutAttributes]
	}
	
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return dynamicAnimator.layoutAttributesForCell(at: indexPath)
	}
	
	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		if let collectionView = collectionView {
			let delta = newBounds.minY - collectionView.bounds.minY
			let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
			
			for behaviour in dynamicAnimator.behaviors as! [UIAttachmentBehavior] {
				let yDistanceFromTouch = abs(touchLocation.y - behaviour.anchorPoint.y)
				let xDistanceFromTouch = abs(touchLocation.x - behaviour.anchorPoint.x)
				let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500
				
				if let item = behaviour.items.first {
					var centre = item.center
					if delta < 0 {
						centre.y += max(delta, delta * scrollResistance)
					}
					else {
						centre.y += min(delta, delta * scrollResistance)
					}
					item.center = centre
					
					dynamicAnimator.updateItem(usingCurrentState: item)
				}
			}
		}
		
		return false
	}*/
}
