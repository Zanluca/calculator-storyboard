//
//  CodeView.swift
//  CalculadoraStoryboard
//
//  Created by gabriel.zanluca on 27/07/22.
//
protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
}
