//
//  iOSArcTouchChallengeTests.swift
//  iOSArcTouchChallengeTests
//
//  Created by Mac on 09/11/18.
//  Copyright © 2018 Ricardo Sgobbe. All rights reserved.
//

@testable import Pods_iOSArcTouchChallenge

import Quick
import Nimble


@testable import iOSArcTouchChallenge

class iOSArcTouchChallengeTests: QuickSpec {

    override func spec() {
        let datasource = MovieDataSource()
        datasource.fetchUpcomingMovie(page: 1) { (movie, error) in
            expect(movie).notTo(beNil())
            expect(error).notTo(beNil())
        }
    }

}
