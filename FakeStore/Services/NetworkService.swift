//
//  NetworkService.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 11.01.25.
//

import Foundation
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
    
}
