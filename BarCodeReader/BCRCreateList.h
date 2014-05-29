//
//  BCRCreateList.h
//  BarCodeReader
//
//  Created by Massimo Moro on 12/05/14.
//  Copyright (c) 2014 MassimoMoro. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BCRCreateList : UIViewController<UITableViewDelegate,UITableViewDataSource >
@property(strong,nonatomic)NSMutableDictionary *iscrizioni;
@property (weak, nonatomic) IBOutlet UITableView *listaIscritti;
@end
