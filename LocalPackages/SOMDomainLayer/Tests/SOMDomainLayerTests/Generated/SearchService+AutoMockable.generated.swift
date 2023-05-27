// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

import UIKit
import Combine
import NasaModels
import DomainInterfaces
@testable import SOMDomainLayer

final class SearchServiceMock: SearchService {
    var currentSearchParameters: CurrentValueSubject<SearchParameters, Never> {
        get { return underlyingCurrentSearchParameters }
        set(value) { underlyingCurrentSearchParameters = value }
    }
    var underlyingCurrentSearchParameters: CurrentValueSubject<SearchParameters, Never>!

    //MARK: - setSearchParameters

    var setSearchParametersWithCallsCount = 0
    var setSearchParametersWithCalled: Bool {
        return setSearchParametersWithCallsCount > 0
    }
    var setSearchParametersWithReceivedParams: SearchParameters?
    var setSearchParametersWithReceivedInvocations: [SearchParameters] = []
    var setSearchParametersWithClosure: ((SearchParameters) -> Void)?

    func setSearchParameters(with params: SearchParameters) {
        setSearchParametersWithCallsCount += 1
        setSearchParametersWithReceivedParams = params
        setSearchParametersWithReceivedInvocations.append(params)
        setSearchParametersWithClosure?(params)
    }

}
