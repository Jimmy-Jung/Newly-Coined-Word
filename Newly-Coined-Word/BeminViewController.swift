//
//  BeminViewController.swift
//  Newly-Coined-Word
//
//  Created by 정준영 on 2023/07/22.
//

import UIKit

class BeminViewController: UIViewController{

    @IBOutlet var imageView: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTap(_:))
        )
        
        imageView.forEach { image in
            image.addGestureRecognizer(tapGesture)
            image.isUserInteractionEnabled = true
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
