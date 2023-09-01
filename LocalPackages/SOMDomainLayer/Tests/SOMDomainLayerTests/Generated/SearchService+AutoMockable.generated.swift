// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import SOMDomainLayer
import Combine
import DomainInterfaces
import NasaModels
import UIKit

final class SearchServiceMock: SearchService {
    var currentSearchParameters: CurrentValueSubject<SearchParameters, Never> {
        get { underlyingCurrentSearchParameters }
        set(value) { underlyingCurrentSearchParameters = value }
    }

    var underlyingCurrentSearchParameters: CurrentValueSubject<SearchParameters, Never>!

    // MARK: - setSearchParameters

    var setSearchParametersWithCallsCount = 0
    var setSearchParametersWithCalled: Bool {
        setSearchParametersWithCallsCount > 0
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
