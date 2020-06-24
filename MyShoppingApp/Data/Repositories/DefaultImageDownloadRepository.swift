//
//  DefaultImageDownloadRepository.swift
//  MyShoppingApp
//
//  Created by Shruthi Salian on 24/06/20.
//  Copyright © 2020 Shruthi Salian. All rights reserved.
//

import Foundation

final class DefaultImageDownloadRepository {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

//MARK: ImageDownloadRepository
extension DefaultImageDownloadRepository: ImageDownloadRepository {
    func fetchImage(with imagePath: String, completion: @escaping (Result<Data?, Error>) -> Void) {
        networkService.request(urlString: imagePath) { (result: Result<Data?, Error>) in

            let result = result.mapError { $0 as Error }
            DispatchQueue.main.async { completion(result) }
        }
    }
}
