//
//  BeminViewController.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/22.
//

import UIKit

class BeminViewController: UIViewController{

    @IBOutlet var imageView: [UIImageView]!
    
    @IBOutlet weak var imageStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        imageView.forEach { image in
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(imageTap(_:))
            )
            image.addGestureRecognizer(tapGesture)
            image.isUserInteractionEnabled = true
        }
        
        if UIScreen.main.bounds.height <= 667 {
            // 아이폰 8의 높이 이하에서만 작동하는 기능을 추가합니다
            imageStackView.isHidden = true
        }

        
        
    }
    @objc func imageTap(_ sender: UITapGestureRecognizer) {
        print("tapped")
        guard let tappedImageView = sender.view as? UIImageView else {return}
        UIView.animate(withDuration: 0.3) {
            tappedImageView.alpha = 0.5
        }
        UIView.animate(withDuration: 0.3) {
            tappedImageView.alpha = 1
        }
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

    
    @IBAction func topButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            sender.tintColor = .black
        }
        UIView.animate(withDuration: 0.3) {
            sender.tintColor = .white
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
