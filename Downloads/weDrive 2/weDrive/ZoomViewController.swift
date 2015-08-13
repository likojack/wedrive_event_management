//
//  ZoomViewController.swift
//  weDrive
//
//  Created by Michelle Lau on 22/07/2015.
//  Copyright (c) 2015 michelle. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate  {


    var image: UIImage? = nil
    
    @IBOutlet weak var ZoomScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ZoomScrollView.minimumZoomScale = 1
        self.ZoomScrollView.maximumZoomScale = 50
        self.ZoomScrollView.delegate = self
        self.imageView.image = self.image!
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }



}
