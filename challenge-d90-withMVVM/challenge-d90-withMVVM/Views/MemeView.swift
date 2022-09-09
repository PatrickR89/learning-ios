//
//  MemeView.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeView: UIView {

    private let imageView = UIImageView()
    private let topTextView = UITextView()
    private let bottomTextView = UITextView()
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
        self.addSubview(topTextView)
        self.addSubview(bottomTextView)

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)

        setupTextView(for: topTextView)
        setupTextView(for: bottomTextView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100)
        ])
    }

    func setupTextView(for textView: UITextView) {

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Enter your text here..."
        textView.textAlignment = .center
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.isScrollEnabled = false
        textView.textContainer.maximumNumberOfLines = 2
        textView.delegate = self

        NSLayoutConstraint.activate([
            topTextView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            topTextView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 20),
            topTextView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75),
            bottomTextView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            bottomTextView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            bottomTextView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75)
        ])
    }

    func setupBindings() {
        viewModel.observeImage { meme in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                let path = FileManager.default.getFilePath(meme.imageName)
                let image = UIImage(contentsOfFile: path.path)
                self.imageView.image = image

                if meme.imageName != "" {
                    if meme.hasTopText {
                        self.topTextView.isHidden = true
                        self.topTextView.isSelectable = false
                    }
                    if meme.hasBottomText {
                        self.bottomTextView.isHidden = true
                        self.bottomTextView.isSelectable = false
                    }
                }
            }
        }
    }

    @objc func imageTapped() {
        delegate?.memeViewDidTapImage(self)
    }
}

extension MemeView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter your text here..." {
            textView.text = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter your text here..."
        } else {
            if textView == topTextView {
                viewModel.updateMemeText(with: textView.text, on: .top)
            } else if textView == bottomTextView {
                viewModel.updateMemeText(with: textView.text, on: .bottom)
            }
        }
    }
}
