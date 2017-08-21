//
//  ServicesPaymentViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

class ServicesPaymentViewController: HampViewController {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    private let cardsProvider = CreditCardsProvider.creditCards
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(ServicesPaymentCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(ServicesPaymentFooterView.self, kind: UICollectionElementKindSectionFooter)
        
    }
    
    //MARK: Actions
    @IBAction func endOrderWasPressed(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ServicesPaymentViewController: UICollectionViewDataSource {
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsProvider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesPaymentCollectionViewCell
        cell.creditCard = cardsProvider[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeReusableSupplementaryView(kind: kind, indexPath: indexPath) as ServicesPaymentFooterView
        reusableView.delegate = self
        return reusableView
    }
}

extension ServicesPaymentViewController: ServicesPaymentFooterDelegate {
    //MARK: Footer delegate
    func footerWasPressed(on footerView: ServicesPaymentFooterView) {
        performSegue(withIdentifier: "presentAddCreditCard", sender: nil)
    }
}

extension ServicesPaymentViewController: UICollectionViewDelegateFlowLayout {
    //MARK: Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let padding: CGFloat = 20
        let size: CGFloat = collectionView.frame.width - padding*2
        return CGSize.init(width: size, height: 72)
    }
}

