//
//  NewsApi.swift
//  SwiftCourseApiCall
//
//  Created by Sainath Bamen on 03/07/23.
//

import Foundation
struct NewsApi:Decodable{
    var status:String
    var totalResults:Int
    var articles:[Article]
}
struct Article: Decodable{
    var author:String?
    var title:String?
    var publishedAt:String?
}
