library(useful)
library(magrittr)
library(dygraphs)
library(xgboost)

land_train <- readr::read_csv('data/manhattan_Train.csv')
land_val <- readRDS('data/manhattan_Validate.rds')

table(land_train$HistoricDistrict)

histFormula <- HistoricDistrict ~ FireService + 
    ZoneDist1 + ZoneDist2 + Class + LandUse + 
    OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + 
    GarageArea + FactryArea + NumBldgs + 
    NumFloors + UnitsRes + UnitsTotal + 
    LotFront + LotDepth + BldgFront + 
    BldgDepth + LotType + Landmark + BuiltFAR +
    Built + TotalValue - 1

landx_train <- build.x(histFormula, data=land_train, 
                       contrasts=FALSE, sparse=TRUE)
landy_train <- build.y(histFormula, data=land_train) %>% 
    as.factor() %>% as.integer() - 1

landx_val <- build.x(histFormula, data=land_val, 
                       contrasts=FALSE, sparse=TRUE)
landy_val <- build.y(histFormula, data=land_val) %>% 
    as.factor() %>% as.integer() - 1


xgTrain <- xgb.DMatrix(data=landx_train, label=landy_train)
xgVal <- xgb.DMatrix(data=landx_val, label=landy_val)

hist1 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=1
)

xgb.plot.multi.trees(hist1, feature_names=colnames(landx_train))


hist2 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=1,
    eval_metric='logloss',
    watchlist=list(train=xgTrain)
)

hist3 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=100,
    eval_metric='logloss',
    watchlist=list(train=xgTrain),
    print_every_n=1
)

hist4 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=500,
    eval_metric='logloss',
    watchlist=list(train=xgTrain),
    print_every_n=1
)

hist5 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=500,
    eval_metric='logloss',
    watchlist=list(train=xgTrain, validate=xgVal),
    print_every_n=1
)

hist5$evaluation_log

dygraph(hist5$evaluation_log)

which.min(hist5$evaluation_log$validate_logloss)

hist6 <- xgb.train(
    data=xgTrain,
    objective='binary:logistic',
    nrounds=which.min(hist5$evaluation_log$validate_logloss),
    eval_metric='logloss',
    watchlist=list(train=xgTrain, validate=xgVal),
    print_every_n=1
)
