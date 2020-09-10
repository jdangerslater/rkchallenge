//
//  TDColourUtil.swift
//  TDMobileUI
//
//  Created by Jason Slater on 2016-12-28.
//  Copyright © 2016 TD Digital Channels. All rights reserved.
//

import UIKit
import Foundation

public extension UIColor {
	
	// MARK: String init
	// Init with a string like "#[AA]RRGGBB" or "0x[AA]RRGGBB"
	
	convenience init (string colour: String) {
		let hex: UInt
		
		if colour.isRGB(orARGB: true) {
			if (colour.first == "#") {
				hex = UInt(colour[colour.index(after: colour.startIndex)...], radix: 16)!
			}
			else {
				hex = UInt(colour[colour.index(colour.startIndex, offsetBy: 2)...], radix: 16)!
			}
		}
		else {
			hex = 0 // init to black if not a valid RGB/ARGB string
		}
		
		self.init(hex: hex)
	}
	
	convenience init (string colour: String, alpha: CGFloat) {
		let hex: UInt
		
		if (colour.isRGB()) {
			if (colour.first == "#") {
				hex = UInt(colour[colour.index(after: colour.startIndex)...], radix: 16)!
			}
			else {
				hex = UInt(colour[colour.index(colour.startIndex, offsetBy: 2)...], radix: 16)!
			}
		}
		else {
			hex = 0 // init to black if not a valid RGB/ARGB string
		}
		
		self.init(hex: hex, alpha: alpha)
	}
	
	
	// MARK: - Int init
	// Init with an integer like 0x[AA]RRGGBB
	
	convenience init (hex: UInt) {
		let a: UInt
		if (hex > 0xffffff) {
			a = hex >> 24 & 0xff
		}
		else {
			a = 255
		}
		self.init (hex:hex & 0xffffff, alpha: CGFloat(a) / 255.0)
	}
	
	convenience init (hex: UInt, alpha: CGFloat) {
		let r: UInt = hex >> 16 & 0xff
		let g: UInt = hex >> 8 & 0xff
		let b: UInt = hex & 0xff
		
		if #available(iOS 10.0, *) {
			self.init(displayP3Red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
		}
		else {
			self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha:
				alpha)
		}
	}
	
}
