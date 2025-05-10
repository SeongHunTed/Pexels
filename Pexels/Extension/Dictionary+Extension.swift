//
//  Dictionary+Extension.swift
//  Pexels
//
//  Created by Hoon on 5/10/25.
//

import Foundation

extension Dictionary where Key == String, Value == String {
	/// 두 개의 [String: String]을 합친다.
	/// - parameter other: 덮어쓸(우선시할) 딕셔너리
	/// - returns: self + other 를 머지한 결과
	func deepMerged(with other: [String: String]) -> [String: String] {
		var merged = self
		other.forEach { merged[$0] = $1 } // 동일 키면 other 값으로 덮어쓰기
		return merged
	}
}
