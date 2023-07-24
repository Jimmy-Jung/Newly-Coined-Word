//
//  ViewController.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/21.
//

import UIKit

class NewWordViewController: UIViewController {
    // MARK: - IBOutLet
    @IBOutlet weak var searchBackgroundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resultUpperView: UIView!
    @IBOutlet weak var resultBackgroundView: UIView!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var resultViewButtonConstraint: NSLayoutConstraint! // 신조어 결과 뷰 높이
    
    // MARK: - Private Properties
    private var ncwDic: [String: String] = [:] // 신조어 딕셔너리
    private let NW = DV.NewWord.self // Default String
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDicData()
        configUI()
        keyboardNotification()
    }

    
    // MARK: - IBAction
    
    ///  뷰 터치시 키보드 내리기
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /// 검색 버튼 선택시 호출
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let text = searchTextField.text, !text.isEmpty else {
            self.showCancelAlert(
                title: NW.alertTitle,
                message: nil,
                preferredStyle: .alert
            )
            return
        }
        let result = ncwDic[text] ?? NW.resultLabelText
        resultTextLabel.text = result
        searchTextField.resignFirstResponder()
    }
    
    // MARK: - Private Methods
    /// JSONParse
    private func getDicData() {
        switch JSONParser().getDicData() {
        case .success(let dic):
            self.ncwDic = dic
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    /// UI 구성
    private func configUI() {
        configSearchBar()
        configScrollView()
        configResultView()
    }
    
    /// 검색창 구성
    private func configSearchBar() {
        // 텍스트 필드
        searchTextField.delegate = self
        searchTextField.becomeFirstResponder()
        // 검색창
        searchBackgroundView.layer.cornerRadius = 10
        searchBackgroundView.layer.borderWidth = 3
        searchBackgroundView.layer.borderColor = UIColor.black.cgColor
        searchBackgroundView.clipsToBounds = true
    }
    
    /// 신조어 표시 뷰 구성
    private func configResultView() {
        // 결과 배경뷰
        resultBackgroundView.layer.borderWidth = 3
        resultBackgroundView.layer.borderColor = UIColor.black.cgColor
        // 결과뷰 윗부분
        resultUpperView.layer.borderWidth = 3
        resultUpperView.layer.borderColor = UIColor.black.cgColor
        // 결과 레이블
        resultTextLabel.font = UIFont.BeminFont(font: .BMHANNA_11yrs_ttf, fontSize: 18)
    }
    
    /// 스크롤뷰 구성
    /// - Parameters:
    ///   - width: 버튼 넓이
    ///   - height: 버튼 높이
    ///   - space: 버튼 간격
    private func configScrollView(
        buttonWidth width: Int = 70,
        buttonHeight height: Int = 30,
        space: Int = 10
    ) {
        var scrollViewWidth: CGFloat = 0
        for (i, dic) in ncwDic.enumerated() {
            let xPos = (width + space) * i
            let button =  makeButton(title: dic.key)
            button.frame = CGRect(x: xPos + 20, y: 0, width: width, height: height)
            button.addTarget(
                self,
                action: #selector(keywordButtonTapped(_:)),
                for: .touchUpInside
            )
            scrollView.addSubview(button)
            scrollViewWidth += CGFloat(width + space)
        }
        scrollView.contentSize.width = scrollViewWidth + 30
    }
    
    /// 신조어 버튼 만들기
    /// - Parameter title: 버튼 제목
    /// - Returns: 버튼
    private func makeButton(title: String) -> UIButton {
        let button =  UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        return button
    }
    
    /// 키보드 노티피케이션 등록
    private func keyboardNotification() {
        // 키보드 올라올 때 알림 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        // 키보드 내려갈 때 알림 등록
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - @objc Method
    /// 키보드 올라갈때 호출 메서드
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        // 신조어 화면 높이 조정 및애니메이션 추가
        UIView.animate(withDuration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25) {
            self.resultViewButtonConstraint.constant = keyboardFrame.height
            self.view.layoutIfNeeded()
        }
    }
    
    /// 키보드 내려갈때 호출 메서드
    @objc func keyboardWillHide(_ notification: Notification) {
        // 신조어 화면 높이 조정 및애니메이션 추가
        UIView.animate(withDuration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval ?? 0.25) {
            self.resultViewButtonConstraint.constant = 250
            self.view.layoutIfNeeded()
        }
    }
    
    /// 신조어 버튼 선택시 호출
    /// - Parameter sender: 신조어 버튼
    @objc func keywordButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .systemGray6
            sender.layer.borderColor = UIColor.darkGray.cgColor
        }
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = .systemGray5
            sender.layer.borderColor = UIColor.black.cgColor
        }
        
        guard let value = sender.titleLabel?.text else {return}
        searchTextField.text = value
        let text = ncwDic[value] ?? NW.resultLabelText
        resultTextLabel.text = text
    }
    // MARK: - Deinitializer
    // 메모리 해제시 옵저버 메모리에서 제거
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - TextFieldDelegate
extension NewWordViewController: UITextFieldDelegate {
    /// 텍스트필드 리턴시 호출
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            self.showCancelAlert(
                title: NW.alertTitle,
                message: nil,
                preferredStyle: .alert
            )
            return true
        }
        let resultText = ncwDic[text] ?? NW.resultLabelText
        resultTextLabel.text = resultText
        // 키보드 내리기
        textField.resignFirstResponder()
        return true
    }
}


