//
//  ServicesPaymentViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 18/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit
import HampKit

class ServicesPaymentViewController: HampViewController {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var endOrderButton: HorizontalCircleGradientButton!

    var ordersManager: OrderManager!

    private var cardsProvider: CreditCardsProvider!
    private var selectedCreditCard: CreditCard?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerReusableCell(ServicesPaymentCollectionViewCell.self)
        collectionView.registerReusableSupplementaryView(ServicesPaymentFooterView.self, kind: UICollectionElementKindSectionFooter)
        cardsProvider = CreditCardsProvider.init()
        setEndOrderDisabled()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    func setEndOrderDisabled() {
        endOrderButton.isEnabled = false
        endOrderButton.alpha = 0.7
    }
    
    //MARK: Actions
    @IBAction func endOrderWasPressed(sender: UIButton) {
        let transaction = TransactionFactory.createTransaction(services: ordersManager.servicesHired(), amount: ordersManager.order.totalAmount, creditCardID: selectedCreditCard!.identifier!)
        
        Hamp.Transactions.createTransaction(transaction: transaction) { (response) in
            if response.code == .ok {
                let newTransaction = response.data!
                ProvidersManager.sharedInstance.hampDataManager.addData (object: DBTransaction.init(transaction: newTransaction))
            } else {
                print("ERROR CREATING TRANSACTION", response.message)
            }
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension ServicesPaymentViewController: UICollectionViewDataSource {
    //MARK: DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsProvider.numberOfCreditCards()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeReusableCell(indexPath: indexPath) as ServicesPaymentCollectionViewCell

        cell.creditCard = cardsProvider.getCreditCardAt(index: indexPath.row)
        cell.cardSelectedDelegate = self
        
        if let selectedCardID = selectedCreditCard?.identifier {
            if selectedCardID != cardsProvider.getCreditCardAt(index: indexPath.row)!.identifier {
                cell.checkBox.isSelected = false
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeReusableSupplementaryView(kind: kind, indexPath: indexPath) as ServicesPaymentFooterView
        reusableView.delegate = self
        return reusableView
    }
}

extension ServicesPaymentViewController: CardSelectedDelegate {
    func cardIsSelected(card: CreditCard) {
        selectedCreditCard = card
        collectionView.reloadData()
        endOrderButton.isEnabled = true
        endOrderButton.alpha = 1
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

