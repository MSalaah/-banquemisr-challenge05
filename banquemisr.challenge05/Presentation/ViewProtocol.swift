//
//  ViewProtocol.swift
//  banquemisr.challenge05
//
//  Created by Moe Salah  on 31/01/2025.
//

protocol ViewProtocol {
    var  onError: (() -> Void)? { get set }
    var  showLoading: (() -> Void)? { get set }
    var  hideLoading: (() -> Void)? { get set }
}
