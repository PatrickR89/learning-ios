//
//  MemeView.swift
//  challenge-d90-withMVVM
//
//  Created by Patrick on 01.09.2022..
//

import UIKit

class MemeView: UIView {

    private let imageView = UIImageView()
    private let imageLayerView = UIImageView()
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

    deinit {
        viewModel.resetImageLayer(withTextDeleteRequest: true)
    }
}

private extension MemeView {
    func setupUI() {
        self.addSubview(imageView)
        self.addSubview(imageLayerView)
        self.addSubview(topTextView)
        self.addSubview(bottomTextView)

        let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        imageLayerView.isUserInteractionEnabled = true
        imageLayerView.addGestureRecognizer(imageTap)

        setupTextView(for: topTextView)
        setupTextView(for: bottomTextView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageLayerView.translatesAutoresizingMaskIntoConstraints = false
        imageLayerView.layer.zPosition = imageView.layer.zPosition + 1

        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit
        imageLayerView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            imageLayerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75),
            imageLayerView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageLayerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageLayerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100)
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
        viewModel.observeMeme { [weak self] (meme) in
            DispatchQueue.main.async {
                guard let self = self else {return}
                let path = FileManager.default.getFilePath(meme.imageName)
                let image = UIImage(contentsOfFile: path.path)
                self.imageView.image = image
            }

        }

        viewModel.observeTopText { topText, meme in
            DispatchQueue.main.async { [weak self] in
                if topText == "" && meme.imageName != "" && !meme.hasTopText {
                    self?.topTextView.isHidden = false
                } else {
                    self?.topTextView.isHidden = true
                }
            }
        }

        viewModel.observeBottomText { bottomText, meme in
            DispatchQueue.main.async { [weak self] in
                if bottomText == "" && meme.imageName != "" && !meme.hasBottomText {
                    self?.bottomTextView.isHidden = false
                } else {
                    self?.bottomTextView.isHidden = true
                }
            }
        }

        viewModel.observeImageLayer { imageText in
            DispatchQueue.main.async { [weak self] in
                self?.imageLayerView.image = imageText
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.topTextView.endEditing(true)
        self.bottomTextView.endEditing(true)
    }
}
