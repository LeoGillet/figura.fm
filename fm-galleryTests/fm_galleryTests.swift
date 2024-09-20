//
//  fm_galleryTests.swift
//  fm-galleryTests
//
//  Created by Léo Gillet on 09/09/2024.
//

import XCTest
@testable import fm_gallery

final class fm_galleryTests: XCTestCase {
    func getRecentTracksTest() async throws {
        let rt = try await requestAndDecodeRecentTracks(user: "LeoGillet")
        XCTAssert(rt is LastFMAPIRecentTracks)
        print(rt)
    }
    
}
