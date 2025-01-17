//
//  Product.swift
//  FakeStore
//
//  Created by Dmitry Kononov on 14.01.25.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Decodable {
        let rate: Double
        let count: Int
    }
    
   static func mock() -> [Product] {
        return [
            Product(id: 5, title: "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet", price: 695, description: "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.", category: "jewelery", image: "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg", rating: Product.Rating(rate: 4.6, count: 400)),
            Product(id: 6, title: "Solid Gold Petite Micropave", price: 168, description: "Satisfaction Guaranteed. Return or exchange any order within 30 days.Designed and sold by Hafeez Center in the United States. Satisfaction Guaranteed. Return or exchange any order within 30 days.", category: "jewelery", image: "https://fakestoreapi.com/img/61sbMiUnoGL._AC_UL640_QL65_ML3_.jpg", rating: Product.Rating(rate: 3.9, count: 70)),
            Product(id: 7, title: "White Gold Plated Princess", price: 9.99, description: "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her. Gifts to spoil your love more for Engagement, Wedding, Anniversary, Valentine's Day...", category: "jewelery", image: "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg", rating: Product.Rating(rate: 3.0, count: 400)),
            Product(id: 8, title: "Pierced Owl Rose Gold Plated Stainless Steel Double", price: 10.99, description: "Rose Gold Plated Double Flared Tunnel Plug Earrings. Made of 316L Stainless Steel", category: "jewelery", image: "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg", rating: Product.Rating(rate: 1.9, count: 100))
        ]
    }
}

struct ProductsResponce: Decodable {
    let products: [Product]
}

//{
//  "id": 5,
//  "title": "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet",
//  "price": 695,
//  "description": "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection.",
//  "category": "jewelery",
//  "image": "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
//  "rating": {
//    "rate": 4.6,
//    "count": 400
//  }
//},
