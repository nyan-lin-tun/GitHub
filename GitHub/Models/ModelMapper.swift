//
//  ModelMapper.swift
//  GitHub
//
//  Created by Nyan Lin Tun on 16/5/25.
//

import Foundation

protocol ModelMapper {
    associatedtype Input
    associatedtype Output
    
    func map(input: Input) -> Output
}
