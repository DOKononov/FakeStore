//
//  NetworkService.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 11.01.25.
//

import UIKit
import RxSwift

enum NetworkError: Error {
    case incorrectUrl
}

final class NetworkService {
    
    private let host: String = "https://fakestoreapi.com/"
    
    func loadCategories() -> Observable<[String]> {
        guard let url = URL(string: "\(host)products/categories") else {
            return Observable.create {
                $0.onError(NetworkError.incorrectUrl)
                return Disposables.create {}
            }}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.rx.data(request: request)
            .compactMap { try JSONDecoder().decode([String].self, from: $0) }
    }
    
    func load(category: String) -> Observable<[Product]> {
        guard let url = URL(string: "\(host)products/category/\(category)") else {
            return .error(NetworkError.incorrectUrl)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return URLSession.shared.rx.data(request: request)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .compactMap { try JSONDecoder().decode([Product].self, from: $0)}
            .observe(on: MainScheduler.asyncInstance)
    }
        
    func loadImage(from urlString: String) -> Observable<UIImage?> {
        guard let url = URL(string: urlString) else {
            return .error(NetworkError.incorrectUrl)
        }
        
        return URLSession.shared.rx.data(request: URLRequest(url: url))
            .map { UIImage(data: $0) }
            .catchAndReturn(nil)
    }
        
}

