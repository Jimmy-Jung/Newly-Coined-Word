//
//  DefaultValue.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/24.
//

import Foundation

struct DV {
    enum fileName {
        static let sinJoA = "SinJoA"
    }
    
    enum JSONErrorString {
        static let wrongLocation = "경로가 잘못되었습니다."
        static let somethingWrong = "뭔가 잘못되었습니다."
    }
    
    enum NewWord {
        static let alertTitle = "텍스트를 입력해주세요!!"
        static let resultLabelText = "신조어가 없습니다."
    }
}
