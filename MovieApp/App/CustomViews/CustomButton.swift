//
//  CustomButton.swift
//  MovieApp
//
//  Created by Ali Beyaz on 1.11.2023.
//


import UIKit


class CustomGradientButton: UIButton {
    private var title: String?
    private var iconImageView: UIImageView?
    
    init(title: String?, icon: UIImage?) {
        super.init(frame: .zero)
        
        self.title = title
        
        if let icon = icon {
            self.iconImageView = UIImageView(image: icon)
            self.iconImageView?.contentMode = .scaleAspectFit
            self.addSubview(self.iconImageView!)
        }
        
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateDottedBorderPath()
    }
    
    
    func setupUI() {
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.green, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.backgroundColor = .clear
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.addDottedBorder()
        
        iconImageView?.tintColor = .green
        addSubview(iconImageView!)
        iconImageView!.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(titleLabel!.snp.left).offset(-8)
        }
    }
    
    func addDottedBorder() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = UIColor.green.cgColor
        borderLayer.lineDashPattern = [10, 10]
        borderLayer.lineWidth = 1
        borderLayer.fillColor = nil
        self.layer.addSublayer(borderLayer)
        self.dottedBorderLayer = borderLayer
        self.updateDottedBorderPath()
    }
    
    var dottedBorderLayer: CAShapeLayer?
    
    func updateDottedBorderPath() {
        if let borderLayer = self.dottedBorderLayer {
            let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
            borderLayer.path = path.cgPath
        }
    }
}
