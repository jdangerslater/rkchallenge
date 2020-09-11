//
//  RequestObservable.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-07.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import Foundation
import RxSwift

class RequestObservable {
	private lazy var jsonDecoder = JSONDecoder()
	private var urlSession: URLSession

	init(config: URLSessionConfiguration) {
		urlSession = URLSession(configuration: config)
	}
	
	func loadJSON<ItemModel: Decodable>(url: URL) -> Observable<ItemModel> {
		return Observable.create { [weak self] observer -> Disposable in
			let task = self?.urlSession.dataTask(with: url) { data, response, error in
				let rawData = data ?? Data()
				do {
					if let trophyData = try self?.jsonDecoder.decode(ItemModel.self, from: rawData) {
						observer.onNext(trophyData)
					}
					else {
						observer.onError(RequestError.noData)
					}
				}
				catch {
					observer.onError(error)
				}
			}
			
			task?.resume()
			return Disposables.create {
				task?.cancel()
			}
		}
	}
}


extension RequestObservable {
	enum RequestError: String, Error {
		case noData
	}
}
