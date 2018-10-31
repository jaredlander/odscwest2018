data(father.son, package='UsingR')
head(father.son)

library(ggplot2)
ggplot(father.son, aes(x=fheight, y=sheight)) + 
    geom_point() +
    geom_smooth(method='lm')

height1 <- lm(sheight ~ fheight, data=father.son)
coef(height1)

33.88 + 0.51*60
33.88 + 0.51*72

land_train <- readr::read_csv('data/manhattan_Train.csv')

View(land_train)

valueFormula <- TotalValue ~ FireService + 
    ZoneDist1 + ZoneDist2 + Class + LandUse + 
    OwnerType + LotArea + BldgArea + ComArea + 
    ResArea + OfficeArea + RetailArea + 
    GarageArea + FactryArea + NumBldgs + 
    NumFloors + UnitsRes + UnitsTotal + 
    LotFront + LotDepth + BldgFront + 
    BldgDepth + LotType + Landmark + BuiltFAR +
    Built + HistoricDistrict - 1