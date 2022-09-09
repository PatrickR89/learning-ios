//
//  ShareView.swift
//  challenge-d90-withMVVM-share
//
//  Created by Patrick on 09.09.2022..
//

import UIKit

class ShareView: UIView {

    let viewModel: ShareViewModel
    let title = UILabel()
    let imageView = UIImageView()
    let acceptBtn = UIButton()
    let cancelBtn = UIButton()
    let stackView = UIStackView()

    init(with viewModel: ShareViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupBindings()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupBindings() {
        viewModel.observeImage { savedImage in
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = savedImage
            }
        }
    }

    func setupUI() {
        self.addSubview(imageView)
        self.addSubview(stackView)
        self.addSubview(title)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        title.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        title.text = "Add image to Memes"

        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit

        setupStackView()

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -50),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = CGFloat(15)

        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.backgroundColor = .systemRed
        acceptBtn.setTitle("Add", for: .normal)
        acceptBtn.backgroundColor = .systemBlue

        cancelBtn.addTarget(self, action: #selector(cancelRequest), for: .touchUpInside)
        acceptBtn.addTarget(self, action: #selector(fullfillRequest), for: .touchUpInside)

        let buttons: [UIButton] = [cancelBtn, acceptBtn]

        for button in buttons {
            button.layer.cornerRadius = 3
            button.widthAnchor.constraint(equalToConstant: 150).isActive = true
            stackView.addArrangedSubview(button)
        }
    }

    @objc private func fullfillRequest() {
        viewModel.saveImage()
    }

    @objc private func cancelRequest() {
        viewModel.cancelRequest()
    }
}
