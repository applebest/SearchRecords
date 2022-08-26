//
//  SearchRecords.swift
//  test1
//
//  Created by clt on 2022/8/24.
//

import UIKit


struct SearchRecordsTextConfig{
    static let textFont = UIFont.systemFont(ofSize: 12)
}

class SearchRecordsCell:UICollectionViewCell {
    
    private let  containerView : UIView = UIView()
    
    let  textLabel:UILabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        textLabel.font = SearchRecordsTextConfig.textFont
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.black
        self.containerView.layer.cornerRadius = 10
        self.containerView.layer.masksToBounds = true
        self.containerView.backgroundColor = UIColor.white
        self.containerView.addSubview(textLabel)
        self.contentView.addSubview(containerView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.frame = self.contentView.bounds
        self.textLabel.center = self.contentView.center
        self.textLabel.bounds.size.width = self.contentView.bounds.size.width - 6
        self.textLabel.bounds.size.height = self.contentView.bounds.size.height - 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// 获取当前所需宽度
protocol SearchRecordsLayoutDelegate:NSObjectProtocol {
    func searchRecordsLayoutGetCurrentIndexWidth(indexPath: IndexPath) -> CGFloat
}



class SearchRecordsLayout:UICollectionViewFlowLayout {
    
    private var layoutCaches:[UICollectionViewLayoutAttributes] = []
    
    private var point:CGPoint = CGPoint()
    
    var itemHeight : CGFloat = 20
    
    var leftSpace:CGFloat = 5
    var topSpace:CGFloat  = 5
    var sectionHeaderHeight:CGFloat = 30
    var currentSection = 0
    private var maxWidth : CGFloat = 0
    
    weak var delegate:SearchRecordsLayoutDelegate?
    
    override func prepare() {
        super.prepare()
        currentSection = 0
        point.x = leftSpace
        point.y = topSpace
        let w = ( (self.collectionView?.bounds.size.width ?? 0) - leftSpace * 2 )
        maxWidth = w < 0 ? UIScreen.main.bounds.size.width - leftSpace * 2 : w
        layoutCaches.removeAll()
        
        guard let collectionView = self.collectionView else {return}
        let section = collectionView.numberOfSections
        
//        guard let count = self.collectionView?.numberOfItems(inSection: 0) else { return }
        
        for s in 0..<section {
             let count = collectionView.numberOfItems(inSection: s)
            if let sectionAttributes =  self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath.init(item: 0, section: s)){
                layoutCaches.append(sectionAttributes)
            }
             for item in 0..<count {
                let indexPath = IndexPath.init(item: item, section: s)
                guard let layoutAttributes = self.layoutAttributesForItem(at: indexPath) else { return }
                layoutCaches.append(layoutAttributes)
            }
          
        }
        
        
//        for item in 0..<count{
//            let indexPath = IndexPath.init(item: item, section: 0)
//            guard let layoutAttributes = self.layoutAttributesForItem(at: indexPath) else { return }
//            layoutCaches.append(layoutAttributes)
//        }
    }
    
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let delegate = delegate else {
           return nil
        }
        
        guard let collectionView = self.collectionView else {
            return nil
        }
        
        guard let _ = collectionView.dataSource else {
             print("dataSource 未实现")
            return nil
        }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        if currentSection != indexPath.section {
            currentSection = indexPath.section
            point.x = leftSpace
        }
        
        var  width:CGFloat = delegate.searchRecordsLayoutGetCurrentIndexWidth(indexPath: indexPath) + SearchRecordsTextConfig.textFont.pointSize
        width = min(width, maxWidth)

        if (point.x + width )  > collectionView.bounds.size.width{
            point.x = leftSpace
            point.y += itemHeight + topSpace
        }

        attributes.frame = CGRect(x: point.x, y: point.y, width: width, height: itemHeight)
        point.x += (width + leftSpace)
        
        
        
//        var  width:CGFloat = delegate.searchRecordsLayoutGetCurrentIndexWidth(indexPath: indexPath) + SearchRecordsTextConfig.textFont.pointSize
//        width = min(width, maxWidth)
//        let rect = CGRect(x:point.x , y:  point.y , width: width, height: self.itemHeight)
//        attributes.frame = rect
//        var nextWidth : CGFloat = 0
//        if indexPath.item + 1 < dataSource.collectionView(collectionView, numberOfItemsInSection: indexPath.section) {
//            nextWidth = delegate.searchRecordsLayoutGetCurrentIndexWidth(indexPath: IndexPath.init(item: indexPath.item + 1, section: indexPath.section)) + SearchRecordsTextConfig.textFont.pointSize
//        }
//
//
//        if (rect.maxX  + leftSpace + nextWidth)  >= self.collectionView?.bounds.size.width ?? 0 {
//            self.point.x = leftSpace
//            self.point.y = rect.maxY + topSpace
//        }else{
//            point.x +=  (width + leftSpace)
//        }
        
        
        

        
        return attributes
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes.init(forSupplementaryViewOfKind: elementKind, with: indexPath)
        
        if point.x > leftSpace {
            point.y += itemHeight + topSpace
        }
        
        attributes.frame = CGRect(x: 0, y: point.y - topSpace , width: collectionView?.bounds.size.width ?? 0, height: sectionHeaderHeight)
        point.y += sectionHeaderHeight
        return attributes
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.layoutCaches
    }

    override var collectionViewContentSize: CGSize{
        
        let y = self.point.x > leftSpace ? (self.point.y + itemHeight + topSpace) : point.y
        
        return CGSize(width: self.collectionView?.bounds.size.width ?? UIScreen.main.bounds.size.width , height: y)

    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
    
    
    
}

class SearchRecordsHeader : UICollectionReusableView {
    
    let label:UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "搜索记录"
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.label.frame = self.bounds
    }
    
}



class SearchRecordsView: UIView {
    
   
   private let layout = SearchRecordsLayout()
    
   private lazy var collectionView: UICollectionView = {
       let temp = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
       temp.backgroundColor = .red
       layout.delegate = self
       temp.register(SearchRecordsHeader.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: NSStringFromClass(SearchRecordsHeader.self))
       temp.register(SearchRecordsCell.self, forCellWithReuseIdentifier: NSStringFromClass(SearchRecordsCell.self))
       temp.delegate = self
       temp.dataSource = self
        return temp
    }()
    
    var dataSource:[[String]] = [[String]]() {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    var didSelectedBlock:((IndexPath)->Void)?
    
   required convenience  init(frame: CGRect ,dataSource:[[String]]) {
        self.init(frame: frame)
        self.dataSource = dataSource
       self.addSubview(self.collectionView)
       self.collectionView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension SearchRecordsView : UICollectionViewDelegate , UICollectionViewDataSource ,SearchRecordsLayoutDelegate {
    
    func searchRecordsLayoutGetCurrentIndexWidth(indexPath: IndexPath) -> CGFloat {
        
        let string = self.dataSource[indexPath.section][indexPath.item]
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: layout.itemHeight)

        let rect = string.boundingRect(with:constraintRect, options: .usesLineFragmentOrigin, attributes: [.font:SearchRecordsTextConfig.textFont], context: nil)
        
        return ceil(rect.width)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(SearchRecordsHeader.self), for: indexPath) as! SearchRecordsHeader
        header.label.text = indexPath.section % 2 == 0 ? "搜索记录":"历史记录"
        
        
//        header.backgroundColor = .white
//        header.backgroundColor = .green
        return header
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard  let cell : SearchRecordsCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(SearchRecordsCell.self), for: indexPath) as?SearchRecordsCell  else {
            return UICollectionViewCell()
        }
       
        cell.textLabel.text = self.dataSource[indexPath.section][indexPath.item]

        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.didSelectedBlock?(indexPath)
    }
    
    
}


