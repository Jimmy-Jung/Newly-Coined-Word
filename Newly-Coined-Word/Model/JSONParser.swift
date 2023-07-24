//
//  NewlyCoinedWords.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/21.
//

import Foundation

/// JSON 파싱
struct JSONParser {
    
    /// JSON 로드 에러 타입
    enum JSONLoadError: Error {
        case wrongLocation
        case somethingWrong
        
        /// String 변환
        var localizedDescription: String {
            let ST = DV.JSONErrorString.self
            switch self {
            case .wrongLocation:
                return ST.wrongLocation
            case .somethingWrong:
                return ST.wrongLocation
            }
        }
    }
    // MARK: - Private Methods

    /// 로컬 파일 로드하기
    /// - Parameters:
    ///   - fileName: 파일명
    ///   - extensionType: 확장자 타입
    /// - Returns: 데이터
    private func load(fileName: String, extensionType: String = "json") -> Data? {
        // 3. 파일 위치
        guard let fileLocation = Bundle.main.url(
            forResource: fileName,
            withExtension: extensionType
        ) else {
            return nil
        }
        
        do {
            // 4. 해당 위치의 파일을 Data로 초기화하기
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            // 5. 잘못된 위치나 불가능한 파일 처리
            return nil
        }
    }
    
    /// JSON 데이터 패치
    /// - Returns: Result<NCWList, JSONLoadError>
    private func fetchData() -> Result<NCWList, JSONLoadError> {
        do {
            guard let jsonData = load(fileName: DV.fileName.sinJoA) else {return .failure(.wrongLocation)}
            let ncwList = try JSONDecoder().decode(NCWList.self, from: jsonData)
            return .success(ncwList)
        } catch {
            return .failure(.somethingWrong)
        }
    }
    // MARK: - Public Methods
    
    /// 딕셔너리 값 가져오기
    /// - Returns: Result<[String: String], JSONLoadError>
    public func getDicData() -> Result<[String: String], JSONLoadError> {
        switch fetchData() {
        case .success(let ncwList):
            var dict = [String: String]()
            for ncw in ncwList.lists {
                dict[ncw.name] = ncw.description
            }
            return .success(dict)
        case .failure(let error):
            return .failure(error)
        }
    }
}



