/*
* Copyright (c) 2021 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

import Foundation

/// Protocol for app version information
protocol AppVersionInformation {

	/// The minimum required version
	var minimumVersion: String { get }

	/// The message for the minium required version
	var minimumVersionMessage: String? { get }

	/// The url to the appStore
	var appStoreURL: URL? { get }

	/// The url to the site
	var informationURL: URL? { get }

	/// Is the app deactvated?
	var appDeactivated: Bool? { get }

	/// What is the TTL of the config
	var configTTL: Int? { get }

	/// What is the TTL of a test
	var maxValidityHours: Int? { get }
}

extension AppVersionInformation {

	/// Is the app deactivated?
	var isDeactivated: Bool {

		return appDeactivated ?? false
	}
}

struct RemoteConfiguration: AppVersionInformation, Codable {

	/// The minimum required version
	let minimumVersion: String

	/// The message for the minium required version
	let minimumVersionMessage: String?

	/// The url to the appStore
	let appStoreURL: URL?

	/// The url to the site
	let informationURL: URL?

	/// Is the app deactvated?
	let appDeactivated: Bool?

	/// What is the TTL of the config
	let configTTL: Int?

	/// What is the TTL of a test
	var maxValidityHours: Int?

	/// Key mapping
	enum CodingKeys: String, CodingKey {

		case minimumVersion = "iosMinimumVersion"
		case minimumVersionMessage = "iosMinimumVersionMessage"
		case appStoreURL = "iosAppStoreURL"
		case appDeactivated = "appDeactivated"
		case informationURL = "informationURL"
		case configTTL = "configTTL"
		case maxValidityHours = "maxValidityHours"
	}

	/// Initializer
	/// - Parameters:
	///   - minVersion: The minimum required version
	///   - minVersionMessage: The message for the minium required version
	///   - storeUrl: The url to the appStore
	///   - deactiviated: The deactivation String
	///   - informationURL: The information url
	///   - configTTL: The TTL of the config
	///   - maxValidityHours: The TTL of the test proof
	init(
		minVersion: String,
		minVersionMessage: String?,
		storeUrl: URL?,
		deactivated: Bool?,
		informationURL: URL?,
		configTTL: Int?,
		maxValidityHours: Int?) {
		
		self.minimumVersion = minVersion
		self.minimumVersionMessage = minVersionMessage
		self.appStoreURL = storeUrl
		self.appDeactivated = deactivated
		self.informationURL = informationURL
		self.configTTL = configTTL
		self.maxValidityHours = maxValidityHours
	}

	/// Default remote configuration
	static var `default`: RemoteConfiguration {
		return RemoteConfiguration(
			minVersion: "1.0.0",
			minVersionMessage: nil,
			storeUrl: nil,
			deactivated: false,
			informationURL: nil,
			configTTL: 3600,
			maxValidityHours: 48
		)
	}
}
