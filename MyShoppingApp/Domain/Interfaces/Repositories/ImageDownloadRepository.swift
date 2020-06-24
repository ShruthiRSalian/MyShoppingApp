//
//  ImageDownloadRepository.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 23/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

protocol ImageDownloadRepository {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void)
}
