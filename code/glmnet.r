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

value1 <- lm(valueFormula, data=land_train)
coef(value1)
summary(value1)

library(coefplot)
coefplot(value1,sort='magnitude')


sports <- c('Hockey', 'Lacrosse', 'Curling', 'Football', 
            'Hockey', 'Curling', 'Hockey')
sports
model.matrix( ~ sports)

boros <- tibble::tribble(
    ~ Boro, ~ Pop, ~ Size, ~ Random,
    'Manhattan', 1600000, 23, 13,
    'Brooklyn', 2600000, 78, 42,
    'Queens', 2330000, 104, 26,
    'Bronx', 1500000, 42, 1,
    'Staten Island', 480000, 60, 7
)

boros

library(useful)

build.x( ~ Pop, data=boros)
build.x( ~ Pop + Size, data=boros)
build.x( ~ Pop * Size, data=boros)
build.x( ~ Pop : Size, data=boros)
build.x( ~ Pop + Size - 1, data=boros)
build.x( ~ Pop + Boro, data=boros)
build.x( ~ Pop + Boro, data=boros, contrasts=FALSE)
build.x( ~ Pop + Boro, data=boros, contrasts=FALSE, sparse=TRUE)


landx_train <- build.x(valueFormula, data=land_train, 
                       contrasts=FALSE, sparse=TRUE)
landy_train <- build.y(valueFormula, data=land_train)

landx_train
head(landy_train, n=30)

denseX <- build.x(valueFormula, data=land_train, 
                  contrasts=FALSE, sparse=FALSE)
pryr::object_size(landx_train)
pryr::object_size(denseX)

library(glmnet)
value2 <- glmnet(x=landx_train, y=landy_train, family='gaussian')

View(as.matrix(coef(value2)))

plot(value2, xvar='lambda')
plot(value2, xvar='lambda', label=TRUE)
coefpath(value2)

library(animation)
cv.ani(k=10)

set.seed(11235)
value3 <- cv.glmnet(x=landx_train, y=landy_train, 
                    family='gaussian', 
                    nfolds=5)
plot(value3)
