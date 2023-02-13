//
//  PostController.swift
//  Instagram Clone
//
//  Created by Erick El nino on 2023/01/24.
//  Copyright © 2023 Erick El nino. All rights reserved.
//

import UIKit


class PostController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configure()
    }
}

extension PostController
{
    private func style()
    {
        view.backgroundColor = .white
    }
    private func configure()
    {
        let controller = SelectImageViewController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
}



