//
//  URLTransform.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-27.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2015 Hearst
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

open class URLTransform: TransformType {
	public typealias Object = URL
	public typealias JSON = String
	private let shouldEncodeURLString: Bool

	/**
	Initializes the URLTransform with an option to encode URL strings before converting them to an NSURL
	- parameter shouldEncodeUrlString: when true (the default) the string is encoded before passing
	to `NSURL(string:)`
	- returns: an initialized transformer
	*/
	public init(shouldEncodeURLString: Bool = true) {
		self.shouldEncodeURLString = shouldEncodeURLString
	}

	public func transformFromJSON(_ value: Any?) -> URL? {
		guard let URLString = value as? String else { return nil }
		
		if !shouldEncodeURLString {
			return URL(string: URLString)
		}
		
		guard let escapedURLString = URLString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
			return nil
		}
		return URL(string: escapedURLString)
	}

	public func transformToJSON(_ value: URL?) -> String? {
		if let URL = value {
			return URL.absoluteString
		}
		return nil
	}
}
