//
//  iOSTakeHomeChallengeTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Hashim Akhtar on 13/05/2025.
//

import Testing
@testable import iOSTakeHomeChallenge

struct iOSTakeHomeChallengeTests {

    @Test func characterExamples() async throws {
        let exampleCharacters = Character.examples
        #expect(exampleCharacters.count > 0)
    }

}
