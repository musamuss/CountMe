//
//  CollectionViewController.swift
//  SwiftInstagramAPI
//
//  Created by Игорь Силаев and musamuss on 19/04/2019.
//  Copyright © 2019 Игорь Силаев. All rights reserved.
//

import CollectionKit
import SwiftInstagram
class CollectionViewController: UIViewController {
    
    let collectionView = CollectionView()
    
    var provider: Provider? {
        get { return collectionView.provider }
        set { collectionView.provider = newValue }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.animator = FadeAnimator()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

