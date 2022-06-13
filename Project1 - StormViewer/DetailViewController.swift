//
//  DetailViewController.swift
//  Project1 - StormViewer
//
//  Created by Vitali Vyucheiski on 3/1/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage : String?
    var picturesNumbersOut : String = ""
    var pictureName = ""
    var displayedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = picturesNumbersOut
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
        
        if let imageToLoad = selectedImage {
            displayedImage = UIImage(named: imageToLoad)
            imageView.image = displayedImage
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        let imageWithWatermark = textToImage()
        guard let image = imageWithWatermark.jpegData(compressionQuality: 1) else
            {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, pictureName], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func textToImage() -> UIImage {
        let text = "StormViewer"
        let point = CGPoint(x: 40, y: 40)
        
        let textColor = UIColor.red
        let textFont = UIFont(name: "Helvetica Bold", size: 34)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(displayedImage!.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        displayedImage!.draw(in: CGRect(origin: CGPoint.zero, size: displayedImage!.size))

        let rect = CGRect(origin: point, size: displayedImage!.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

}
