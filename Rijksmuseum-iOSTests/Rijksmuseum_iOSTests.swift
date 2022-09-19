//
//  Rijksmuseum_iOSTests.swift
//  Rijksmuseum-iOSTests
//
//  Created by Dragos-Costin Mandu on 9/19/22.
//

import XCTest
@testable import Rijksmuseum_iOS

final class Rijksmuseum_iOSTests: XCTestCase {
    
    private let rijksmuseumWorker = RijksmuseumWorker()
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func testRijksmuseumModelsLinksInit() {
        let dto = RijksmuseumApiDtos.Links(self: "https://rijksmuseum.nl",
                                           web: "https://rijksmuseum.nl",
                                           search: "https://google.com")
        let model = RijksmuseumModels.Links(with: dto)
        
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.selfLink)
        XCTAssertNotNil(model?.webLink)
        XCTAssertNotNil(model?.searchLink)
        
        XCTAssertEqual(model?.selfLink?.absoluteURL,
                       model?.webLink?.absoluteURL)
        XCTAssertNotEqual(model?.selfLink?.absoluteURL,
                          model?.searchLink?.absoluteURL)
    }
    
    func testRijksmuseumModelsLinksInitWithNilValues() {
        let dto = RijksmuseumApiDtos.Links(self: nil,
                                           web: nil,
                                           search: nil)
        let model = RijksmuseumModels.Links(with: dto)
        
        XCTAssertNotNil(model)
        XCTAssertNil(model?.selfLink)
        XCTAssertNil(model?.webLink)
        XCTAssertNil(model?.searchLink)
    }

    func testRijksmuseumModelsImageInfoInit() {
        let dto = RijksmuseumApiDtos.ImageInfo(guid: "guid",
                                               offsetPercentageX: 1,
                                               offsetPercentageY: 2,
                                               width: 10,
                                               height: 10,
                                               url: "https://rijksmuseum.nl")
        let model = RijksmuseumModels.ImageInfo(with: dto)
        
        XCTAssertNotNil(model)
        XCTAssertNotNil(model?.guid)
        XCTAssertNotNil(model?.offsetPercentage)
        XCTAssertNotNil(model?.size)
        XCTAssertNotNil(model?.url)
    }
    
    func testRijksmuseumModelsImageInfoInitWithNilValues() {
        let dto = RijksmuseumApiDtos.ImageInfo(guid: nil,
                                               offsetPercentageX: nil,
                                               offsetPercentageY: nil,
                                               width: nil,
                                               height: nil,
                                               url: nil)
        let model = RijksmuseumModels.ImageInfo(with: dto)
        
        XCTAssertNotNil(model)
        XCTAssertNil(model?.guid)
        XCTAssertNil(model?.offsetPercentage)
        XCTAssertNil(model?.size)
        XCTAssertNil(model?.url)
    }
    
    func testRijksmuseumModelsCollectionDetailsAcquisitionInit() {
        let dto = RijksmuseumApiDtos.CollectionDetails.Acquisition(method: "method",
                                                                   date: "1908-03-15T00:00:00")
        let model = RijksmuseumModels.CollectionDetails.Acquisition(with: dto)
        
        XCTAssertNotNil(model.method)
        XCTAssertNotNil(model.date)
        XCTAssertEqual(model.date?.formatted(date: .abbreviated, time: .omitted), "15 Mar 1908")
    }
    
    func testRijksmuseumModelsCollectionDetailsAcquisitionInitWithNilValues() {
        let dto = RijksmuseumApiDtos.CollectionDetails.Acquisition(method: nil,
                                                                   date: nil)
        let model = RijksmuseumModels.CollectionDetails.Acquisition(with: dto)
        
        XCTAssertNil(model.method)
        XCTAssertNil(model.date)
    }
    
    func testRijksmuseumWorkerGetCollections() async throws {
        let reqDto = RijksmuseumApiDtos.GetCollections.Request(culture: .en,
                                                               involvedMaker: nil,
                                                               page: 0,
                                                               pageSize: 10)
        let collectionList = try await rijksmuseumWorker.getCollections(with: reqDto)
        
        XCTAssertTrue(collectionList.count == 10)
    }
    
    func testRijksmuseumWorkerGetCollectionDetails() async throws {
        let reqDto = RijksmuseumApiDtos.GetCollectionDetails.Request(culture: .en,
                                                                     objectNumber: "SK-C-5")
        
        let collectionDetails = try await rijksmuseumWorker.getCollectionDetails(with: reqDto)
        
        XCTAssertEqual("SK-C-5", collectionDetails.objectNumber)
    }
    
}
