//
//  TrophyLoader.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-07.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import Foundation
import RxSwift

class TrophyLoader {
	static let shared = TrophyLoader()
	
	lazy var requestObservable = RequestObservable(config: .default)
	
	private init() {}
	
	func loadCase() throws -> Observable<TrophyCase.CaseModel>? {
		guard let url = R.file.trophiesJson() else { throw RequestObservable.RequestError.noData }
		
		return requestObservable.loadJSON(url: url)
	}
}
