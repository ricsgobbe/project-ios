//
//  iOSArcTouchChallengeTests.swift
//  iOSArcTouchChallengeTests
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

@testable import iOSArcTouchChallenge

import Quick
import Nimble

class iOSArcTouchChallengeTests: QuickSpec {
    
    class FakeDataSource: MovieDatasourceProtocol {
        func getApiConfiguration(completion: @escaping (iOSArcTouchChallenge.Configuration?, Error?) -> Void) {
            completion(nil, nil)
        }
        
        func fetchGenreList(completion: @escaping ([Genre]?, Error?) -> Void) {
            let genre: [Genre] = []
            completion(genre, nil)
        }
        
        func fetchUpcomingMovie(page: Int, completion: @escaping (MovieResponse?, Error?) -> Void) {
            
        }
        
        func getMovieDetailsWith(id: Int, completion: @escaping (MovieDetail?, Error?) -> Void) {
            
        }
        
        func search(movie: String, completion: @escaping (MovieResponse?, Error?) -> Void) {
            
        }
        
        
    }
    
    override func spec() {
       let repository = MovieRepository()
        repository.datasource = FakeDataSource()
        describe("Validating datasource") {
            
            context("testing getConfig object", closure: {
                it("should be nil", closure: {
                    repository.downloadConfigObj(completion: { (config, error) in
                        expect(config).to(beNil())
                    })
                })
            })
            
            
            context("testing getGenreList", closure: {
                it("should return a empty array", closure: {
                    repository.downloadGenreList(completion: { (genres, error) in
                        expect(genres).to(beEmpty())
                    })
                })
            })
            
        }
        
    }

}
