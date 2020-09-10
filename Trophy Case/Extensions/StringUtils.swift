//
//  TDString.swift
//  TDMobileUI
//
//  Created by Jason Slater on 2017-01-12.
//  Copyright © 2017 TD Digital Channels. All rights reserved.
//

import UIKit
import Foundation

// MARK: - Colours
// Regex to test if a string is a valid colour, using either a 0x or a # prefix

public extension String {
	
	func isRGB () -> Bool {
		guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{6}\\Z", options: .caseInsensitive) else {
			return false
		}
		
		return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
	}
	
	func isARGB () -> Bool {
		guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{8}\\Z", options: .caseInsensitive) else {
			return false
		}
		
		return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
	}
	
	func isRGB (orARGB: Bool) -> Bool {
		if (orARGB) {
			guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: "\\A(0x|#)[a-f0-9]{6}(?:[a-f0-9]{2})?\\Z", options: .caseInsensitive) else {
				return false
			}
			
			return (regex.matches(in: self, options: .anchored, range: NSMakeRange(0, count)).count > 0)
		}
		
		return isRGB()
	}
	
}
