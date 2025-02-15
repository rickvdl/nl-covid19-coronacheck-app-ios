/*
* Copyright (c) 2021 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
*  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
*
*  SPDX-License-Identifier: EUPL-1.2
*/

import UIKit

class CreateProofViewController: BaseViewController {

	private let viewModel: CreateProofViewModel

	let sceneView = CreateProofView()

	// MARK: Initializers

	init(viewModel: CreateProofViewModel) {

		self.viewModel = viewModel

		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {

		fatalError("init(coder:) has not been implemented")
	}

	// MARK: View lifecycle

	override func loadView() {

		view = sceneView
	}

	override func viewDidLoad() {

		super.viewDidLoad()

		edgesForExtendedLayout = []

		viewModel.$title.binding = { [weak self] in self?.sceneView.title = $0 }
		viewModel.$message.binding = { [weak self] in self?.sceneView.message = $0 }
		viewModel.$buttonTitle.binding = { [weak self] in self?.sceneView.primaryTitle = $0 }

		sceneView.primaryButtonTappedCommand = { [weak self] in
			self?.viewModel.buttonTapped()
		}

		addCloseButton(action: #selector(closeButtonTapped), accessibilityLabel: .close)
	}

	// MARK: - User Interaction

	@objc func closeButtonTapped() {

		viewModel.buttonTapped()
	}
}
