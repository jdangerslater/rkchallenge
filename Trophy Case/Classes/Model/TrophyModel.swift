//
//  TrophiesModel.swift
//  Trophy Case
//
//  Created by Jason Slater on 2020-09-01.
//  Copyright © 2020 Jason Slater. All rights reserved.
//

import Foundation

struct TrophyCase {
	private init() {}
}

extension TrophyCase {
	struct CaseModel: Codable {
		var personalRecords: [TrophyModel]
		var virtualRaces: [TrophyModel]
		
		init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: CaseKeys.self)
			
			personalRecords = try values.decode([TrophyModel].self, forKey: .personalRecords)
			virtualRaces = try values.decode([TrophyModel].self, forKey: .virtualRaces)
		}
		
		func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CaseKeys.self)
			
			try container.encode(personalRecords, forKey: .personalRecords)
			try container.encode(virtualRaces, forKey: .virtualRaces)
		}
	}
	
	struct TrophyModel: Codable {
		let type: TrophyType
		var value: Int
		
		init(type: TrophyType, value: Int = 0) {
			self.type = type
			self.value = value
		}
		
		init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: TrophyKeys.self)
			
			type = try TrophyType(rawValue: values.decode(String.self, forKey: .type)) ?? .invalid
			value = try values.decode(Int.self, forKey: .value)
		}
		
		func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: TrophyKeys.self)
			
			try container.encode(type.rawValue, forKey: .type)
			try container.encode(value, forKey: .value)
		}
		
		func formattedValue() -> String {
			if value == -1 {
				return "\nNot Yet"
			}
			
			switch type {
			case .highestElevation:
				return "\n\(value) ft"
			default:
				let h = value / 3600
				let m = (value % 3600) / 60
				let s = value % 60
				if h > 0 {
					return String(format: "\n%i:%02d:%02d", h, m, s)
				}
				else {
					return String(format: "\n%i:%02d", m, s)
				}
			}
		}
	}
}

extension TrophyCase {
	enum TrophyType: String {
		case longestRun = "longest_run"
		case highestElevation = "highest_elevation"
		case fastest5k = "fast_5k"
		case fastest10k = "fast_10k"
		case halfMarathon = "half_marathon"
		case marathon = "marathon"
		case virtual5K = "virtual_5k"
		case virtual10K = "virtual_10k"
		case virtualHalfMarathon = "virtual_half_marathon"
		case tokyoHakoneEkiden = "tokyo_hakone"
		case hakoneEkiden = "hakone_ekiden"
		case mizunoSingaporeEkiden = "singapore_ekiden"
		case invalid
	}
	
	enum CaseKeys: String, CodingKey {
		case personalRecords = "personal_records"
		case virtualRaces = "virtual_races"
	}
	
	enum TrophyKeys: String, CodingKey {
		case type
		case value
	}
}
