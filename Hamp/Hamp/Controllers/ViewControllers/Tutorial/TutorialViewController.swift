//
//  TutorialViewController.swift
//  Hamp
//
//  Created by Joan Molinas Ramon on 22/8/17.
//  Copyright © 2017 com.hamp.hampiOS. All rights reserved.
//

import UIKit

private struct TutorialContent {
    let imageName: String
    let title: String
    let description: String
    let showStartButton: Bool
}

class TutorialViewController: HampViewController {
    
    
    //MARK: IB Properties
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var startButton: HorizontalGradientButton!
    //MARK: Properties
    private var currentPageNumber: Int = 0
    private var contents:[TutorialContent]!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contents = createContents()
        
        descriptionTextView.minimumZoomScale = 0.8
        
        updateUI(to: 0, changeContent: true, animated: false)
        
        scrollView.contentSize = CGSize.init(width: view.frame.width * 4, height: view.frame.height)
        scrollView.delegate = self
    }
    
}

extension TutorialViewController: UIScrollViewDelegate {
    
    //MARK: Scrollview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percentage = Double(scrollView.contentOffset.x/view.frame.size.width)
        var nextPage = Int.init(round(percentage))
        nextPage = (0 ... contents.count-1).clamp(nextPage)
        let changeContent = nextPage != currentPageNumber
        currentPageNumber = nextPage
        updateUI(to: percentage, changeContent: changeContent)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateUI(to: Double.init(currentPageNumber), ended: true)
    }
    
    private func fontToFitHeight() -> UIFont {
        
        var minFontSize: CGFloat = 20
        var maxFontSize: CGFloat = 250
        var fontSizeAverage: CGFloat = 0
        var textAndLabelHeightDiff: CGFloat = 0
        
        while (minFontSize <= maxFontSize) {
            fontSizeAverage = minFontSize + (maxFontSize - minFontSize) / 2
            
            if let labelText: String = descriptionTextView.text {
                let labelHeight = descriptionTextView.frame.size.height
                
                let testStringHeight = labelText.size(withAttributes: [NSAttributedStringKey.font: descriptionTextView.font?.withSize(fontSizeAverage) as Any]).height
                
                textAndLabelHeightDiff = labelHeight - testStringHeight
                
                if (fontSizeAverage == minFontSize || fontSizeAverage == maxFontSize) {
                    if (textAndLabelHeightDiff < 0) {
                        return (descriptionTextView.font?.withSize(fontSizeAverage - 1))!
                    }
                    return (descriptionTextView.font?.withSize(fontSizeAverage))!
                }
                
                if (textAndLabelHeightDiff < 0) {
                    maxFontSize = fontSizeAverage - 1
                    
                } else if (textAndLabelHeightDiff > 0) {
                    minFontSize = fontSizeAverage + 1
                    
                } else {
                    return (descriptionTextView.font?.withSize(fontSizeAverage))!
                }
            }
        }
        return (descriptionTextView.font?.withSize(fontSizeAverage))!
    }
    
}

private extension TutorialViewController {
    
    //MARK: Private
    func rotateImageView(to percentage: Double, ended: Bool = false) {
        let degreess = Double.pi/2 * percentage
        if ended {
            UIView.animate(withDuration: 0.2, animations: {
                self.circleImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(degreess))
            })
        } else {
            circleImageView.transform = CGAffineTransform.init(rotationAngle: CGFloat(degreess))
        }
        
    }
    
    func changeContentUI(animated: Bool = true) {
        let content = contents[self.currentPageNumber]
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            self.contentImageView.image = UIImage.init(named: content.imageName)
            self.titleLabel.text = content.title
            self.startButton.isHidden = !content.showStartButton
        })
        self.descriptionTextView.text = content.description
    }
    
    func updateUI(to percentage: Double, ended: Bool = false, changeContent: Bool = false, animated: Bool = true) {
        rotateImageView(to: percentage, ended: ended)
        pageControl.currentPage = currentPageNumber
        if changeContent { changeContentUI() }
    }
    
    func createContents() -> [TutorialContent] {
        var contents = [TutorialContent]()
        contents.append(TutorialContent.init(imageName: "tutorial-1", title: "Escoge el servicio", description: "Para disfrutar de las ventajas de Hamp empieza por registrarte. \nDe lo demás, nos encargamos nosotros!", showStartButton: false))
        contents.append(TutorialContent.init(imageName: "tutorial-2", title: "Recibe el código y taquilla", description: "Disfruta de una gran variedad de servicios, que podrás adaptarlos a tus necesidades y obtener un resultado inmejorable", showStartButton: false))
        contents.append(TutorialContent.init(imageName: "tutorial-3", title: "Recoge tu ropa", description: "Una vez finalizado el pedido, es tan sencillo como recibir en tu movil un código y una taquilla, en la que dejarás la ropa, y podrás recogerla en 24h ", showStartButton: false))
        contents.append(TutorialContent.init(imageName: "tutorial-4", title: "¡No pierdas detalle!", description: "Comprueba y revisa todos los movimientos que has hecho con el historial de Hamp", showStartButton: true))
        
        return contents
    }
}

