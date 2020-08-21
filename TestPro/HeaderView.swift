//
//  HeaderView.swift
//  TestPro
//
//  Created by Nazhmeddin Babakhanov on 21.08.2020.
//  Copyright © 2020 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

class HeaderView: UIView{
    var bool = false
    var didPress: (() -> ())?
    
    let incrButton = UIButton()
//    let decrButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        setUpElements()
        setUpConstraints()
        self.backgroundColor = .red
    }
    
    private func setUpElements(){
        addSubview(incrButton)
        
        incrButton.setTitle("Low to High", for: .normal)
        incrButton.addTarget(self, action: #selector(pressIncrButton), for: .touchUpInside)
        incrButton.titleLabel?.textAlignment = .center
//        decrButton.setTitle("", for: .normal)
//        incrButton.addTarget(self, action: #selector(pressDecrButton), for: .touchUpInside)
//        decrButton.titleLabel?.textAlignment = .center
    }
    
    private func setUpConstraints(){
        incrButton.translatesAutoresizingMaskIntoConstraints = false
        incrButton.center = center
        incrButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        incrButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
    }
    
    @objc private func pressIncrButton(){
        didPress?()
        bool.toggle()
        if bool{
            incrButton.setTitle("Low to High", for: .normal)
        }else{
            incrButton.setTitle("High to Low", for: .normal)
        }
        print("pressIncrButton")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
