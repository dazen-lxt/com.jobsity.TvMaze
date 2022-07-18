//
//  TvShowPresenterTests.swift
//  TvMazeTests
//
//  Created by Carlos on 18/07/22.
//

import XCTest
@testable import TvMaze

class TvShowPresenterTests: XCTestCase {
    
    // MARK: - Private properties -
    private var presenter = TvShowPresenter()
    private var mockViewController = TvShowDisplayLogicMocks()
    
    // MARK: - Lifecycle -
    override func setUp() {
        presenter.view = mockViewController
    }

    // MARK: - Tests -
    func testPresentEpisodesFromSameSeason() {
        let episodes: [EpisodeModel] = [
            EpisodeModel(
                id: 1,
                name: "name",
                season: 3,
                number: 31
            ),
            EpisodeModel(
                id: 1,
                name: "name",
                season: 3,
                number: 32
            )
        ]
        presenter.presentEpisodes(episodes)
        XCTAssertTrue(mockViewController.episodes.count == 1)
    }
    
    func testPresentEpisodesFromDifferentSeason() {
        let episodes: [EpisodeModel] = [
            EpisodeModel(
                id: 1,
                name: "name",
                season: 2,
                number: 3
            ),
            EpisodeModel(
                id: 1,
                name: "name",
                season: 3,
                number: 3
            )
        ]
        presenter.presentEpisodes(episodes)
        XCTAssertTrue(mockViewController.episodes.count == 2)
    }
    
    func testPresentShowDetail() {
        let show: TvShowInfoModel = TvShowInfoModel(
            id: 0,
            name: "name",
            genres: ["terror"]
        )
        presenter.presentShowDetail(show)
        XCTAssertTrue(show.id == mockViewController.show?.id)
        XCTAssertTrue(show.name == mockViewController.show?.name)
        XCTAssertTrue(show.genres.joinWords() == mockViewController.show?.genres)
    }
    
}

