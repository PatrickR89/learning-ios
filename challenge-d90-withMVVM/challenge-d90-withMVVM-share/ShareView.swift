//
//  ShareView.swift
//  challenge-d90-withMVVM-share
//
//  Created by Patrick on 09.09.2022..
//

import UIKit

class ShareView: UIView {

    let imageView = UIImageView()
    let acceptBtn = UIButton()
    let cancelBtn = UIButton()
    let stackView = UIStackView()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(imageView)
        self.addSubview(stackView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

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
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
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

        let buttons: [UIButton] = [cancelBtn, acceptBtn]

        for button in buttons {
            button.layer.cornerRadius = 3
            button.widthAnchor.constraint(equalToConstant: 150).isActive = true
            stackView.addArrangedSubview(button)
        }
    }

     func setBackground() {
        let blur  = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.frame
        self.insertSubview(blurView, at: 0)
    }
}
