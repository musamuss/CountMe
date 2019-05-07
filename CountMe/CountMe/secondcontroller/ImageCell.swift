//
//  ImageCell.swift
//  SwiftInstagramAPI
//
//  Created by Игорь Силаев and musamuss on 19/04/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import TinyConstraints
import SwiftInstagram
class ImageCell: UIView {
    
    // MARK: -
    // MARK: Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Common Init
    
    private func commonInit() {
        setupViews()
    }
    
    // MARK: -
    // MARK: Setup Views
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(countLabel)
        
        imageView.edgesToSuperview()
        countLabel.centerInSuperview()
    }
    
    // MARK: -
    // MARK: Views
    
    lazy var imageView: UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var countLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 36)
        label.textColor = UIColor(white: 1.0, alpha: 1)
        return label
    }()
    
    // MARK: -
    // MARK: Handlers
    
    // MARK: -
    // MARK: Populate View with Data
    func populate(with instagramMedia: InstagramMedia) {
        let url = instagramMedia.images.standardResolution.url
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, err in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else {
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        
        task.resume()
        
        if countType == .likes {
            countLabel.text = String(instagramMedia.likes.count)
        } else {
            countLabel.text = String(instagramMedia.comments.count)
        }
        
        
    }
    
}

