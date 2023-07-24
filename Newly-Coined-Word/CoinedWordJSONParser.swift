//
//  NewlyCoinedWords.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/21.
//

import Foundation

struct CoinedWordJSONParser {
    let jsonString = """
    {
        "눈치게임": "눈치를 보며 상황을 파악하는 게임",
        "존버력": "인내심과 끈기를 가지고 일을 끝까지 이어나가는 능력",
        "꿀잼": "굉장히 재미있다는 뜻",
        "무드": "분위기나 상황을 뜻함",
        "페북스타": "페이스북에서 유명한 사람",
        "인싸": "인간관계에 능숙하고 인기가 많은 사람",
        "아웃사이더": "집단에서 제외된 사람",
        "뒷북": "예상치 못하게 늦게 알게 되는 일",
        "막장": "혼란스러우면서도 극단적인 상황",
        "무소속": "단체나 조직에 속하지 않는 상태",
        "존맛": "정말 맛있다는 뜻",
        "블랙컨슈머": "싸고 좋은 걸 구매하는 소비자",
        "매니아": "특정한 것에 대한 집착이나 열광을 뜻함",
        "빵셔틀": "택시를 타지 않고 걸어다니는 사람",
        "요기요대리": "요기요와 같은 배달 어플을 통해 음식을 대신 주문해주는 사람",
        "잘못또": "잘못된 정보를 또 전달하는 사람",
        "고인물": "특정한 주제에 대해 전문적으로 알고 있는 사람",
        "노잼": "심심하다는 뜻",
        "헐값": "너무 싼 가격",
        "집순이": "집에만 있는 사람, 집에서 노는 것을 좋아하는 사람을 뜻"
    }
    """
    
    func parseJSON() -> [String: String] {
        guard let jsonData = jsonString.data(using: .utf8) else { return [:] }
        var dictionary: [String: String] = [:]
        do {
            guard let dict = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    as? [String: String] else {
                return [:]
            }
            dictionary = dict
        } catch {
            print(error.localizedDescription)
        }
        return dictionary
    }
}

