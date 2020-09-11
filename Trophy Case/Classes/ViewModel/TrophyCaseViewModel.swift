//
//  TrophyCaseViewModel.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-01.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import Foundation
import RxSwift

class TrophyCaseViewModel {
	
	var personalRecords = [TrophyCase.TrophyModel]() {
		didSet {
			_completedPersonalRecords = personalRecords.filter({ $0.value >= 0 }).count
		}
	}
	
	var virtualRaces = [TrophyCase.TrophyModel]()
	
	private var _completedPersonalRecords: Int = 0
	var completedPersonalRecords: Int { return _completedPersonalRecords }
	
	let isLoading: PublishSubject<Bool> = PublishSubject()
	
	weak var disposeBag: DisposeBag?
	
	func loadTrophies() {
		guard let disposeBag = disposeBag else { return }
		
		isLoading.onNext(true)
		try? TrophyLoader.shared.loadCase()?.subscribe(onNext: { [weak self] caseData in
			self?.personalRecords = caseData.personalRecords
			self?.virtualRaces = caseData.virtualRaces
			self?.isLoading.onNext(false)
			self?.isLoading.onCompleted()
		}, onError: { [weak self] error in
			self?.isLoading.onNext(false)
			self?.isLoading.onError(error)
		}).disposed(by: disposeBag)
	}
	
}
