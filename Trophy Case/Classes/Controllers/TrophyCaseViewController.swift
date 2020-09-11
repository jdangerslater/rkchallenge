//
//  TrophyCaseViewController.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-01.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let reuseIdentifier = "Cell"
private let headerIdentifier = "Header"

class TrophyCaseViewController: UICollectionViewController {
	
	
	// MARK: Styles
	
	lazy var paragraphStyle: NSParagraphStyle = {
		let style = NSMutableParagraphStyle()
		style.alignment = .center
		
		return style
	}()
	
	lazy var boldStyle: [NSAttributedString.Key: Any] = {
		return [
			.font: UIFont.systemFont(ofSize: 16, weight: .bold),
			.foregroundColor: UIColor.textColour,
			.paragraphStyle: paragraphStyle
		]
	}()
	
	lazy var lightStyle: [NSAttributedString.Key: Any] = {
		return [
			.font: UIFont.systemFont(ofSize: 16, weight: .light),
			.foregroundColor: UIColor.textColour,
			.paragraphStyle: paragraphStyle
		]
	}()
	
	lazy var flowLayout = TrophyCaseFlowLayout()
	
	private let viewModel = TrophyCaseViewModel()
	private let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.collectionView.register(UINib(resource: R.nib.trophyCell),
											  forCellWithReuseIdentifier: reuseIdentifier)
		self.collectionView.register(UINib(resource: R.nib.trophyCaseHeaderView),
											  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
											  withReuseIdentifier: headerIdentifier)

		self.collectionView.collectionViewLayout = flowLayout
		
		let backButton = UIButton(type: .custom)
		backButton.setImage(R.image.back_button(), for: .normal)
		backButton.contentHorizontalAlignment = .left
		backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
		navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
		
		let menuButton = UIButton(type: .custom)
		menuButton.setImage(R.image.ellipsis_button(), for: .normal)
		menuButton.contentHorizontalAlignment = .right
		menuButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
		navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
		
		viewModel.disposeBag = disposeBag
		subscribeToData()
	}

	// MARK: UICollectionViewDataSource

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 2
	}


	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if section == 0 {
			return viewModel.personalRecords.count
		}
		
		return viewModel.virtualRaces.count
	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
		if let trophyCell = cell as? TrophyCell {
			let trophy: TrophyCase.TrophyModel
			if indexPath.section == 0 {
				trophy = viewModel.personalRecords[indexPath.row]
			}
			else {
				trophy = viewModel.virtualRaces[indexPath.row]
			}
			
			trophyCell.setTrophyImage(UIImage(named: trophy.type.rawValue))
			trophyCell.raceDetailsLabel.attributedText = attributedString(for: trophy)
		}
    
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath)
		
		if let headerView = view as? TrophyCaseHeaderView {
			if indexPath.section == 0 {
				headerView.titleLabel.text = R.string.localizable.personal_records()
				headerView.detailsLabel.text = String(format: "%i of %i", viewModel.completedPersonalRecords, viewModel.personalRecords.count)
			}
			else if indexPath.section == 1 {
				headerView.titleLabel.text = R.string.localizable.virtual_races()
			}
		}

		return view
	}

}

extension TrophyCaseViewController {
	func subscribeToData() {
		viewModel.isLoading.subscribe(onNext: { isLoading in
			DispatchQueue.main.async {
				UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
			}
		}, onError: { error in
			DispatchQueue.main.async {
				self.showNoDataError()
			}
		}, onCompleted: {
			DispatchQueue.main.async {
				self.collectionView!.reloadData()
			}
		}).disposed(by: disposeBag)
		
		viewModel.loadTrophies()
	}
	
	func showNoDataError() {
		let alertController = UIAlertController(title: nil, message: R.string.localizable.couldnt_load(), preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
	
	func attributedString(for trophy: TrophyCase.TrophyModel) -> NSAttributedString {
		let string = NSMutableAttributedString(string: trophy.type.rawValue.localised(),
															attributes: boldStyle)
		string.append(NSAttributedString(string: trophy.formattedValue(),
													attributes: lightStyle))
		
		return string
	}
}

extension TrophyCaseViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		guard let flowLayout = collectionViewLayout as? TrophyCaseFlowLayout else {
			return CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: 200)
		}
		
		return CGSize(width: flowLayout.itemWidth, height: flowLayout.itemHeights[indexPath.section])
	}
}
