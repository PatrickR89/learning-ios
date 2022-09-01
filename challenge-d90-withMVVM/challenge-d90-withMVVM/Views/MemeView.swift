//
//  MemeView.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeView: UIView {

    private let imageView = UIImageView()
    var viewModel: MemeViewModel
    weak var delegate: MemeViewDelegate?

    init(with viewModel: MemeViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MemeView {
    func setupUI() {
        self.addSubview(imageView)

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100)
        ])
    }

    func setupBindings() {
        viewModel.observeImage { image in
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }

    @objc func imageTapped() {
        delegate?.memeViewDidTapImage(self)
    }
}
