
##### PARTE 1 #####

library(tidyverse)

# CARGANDO CSV
data1 <- read.csv("db_train_churn.csv",sep=",", header = T)
head(data1)
View(data1)
str(data1)

# MAGENES Y RESETEAR ENTORNO GRAFICO
par(mar=c(0,0,0,0))
dev.off()


# CAMBIO DE NOMBRES DE COLUMNAS 
nombres_de_col <- names(data1)
nombres_de_col = c('Dado_de_baja', 'Edad', 'Sexo', 'Ingreso', 'Tipo_Contrato', 'Meses_adeudo', 'Numero_quejas', 'Debito_autom', 'Var_cuota_ult_ano', 'Anos_como_cliente', 'Recibio_oferta')
names(data1) = nombres_de_col
View(data1)

# CONVIERTO A FACTOR LAS COLUMNAS QUE CORRESPONDEN
data1$Sexo = as.factor(data1$Sexo)
data1$Tipo_Contrato = factor(data1$Tipo_Contrato,
                             labels = c("Prepago","Basico","Superior", "Premium"))
data1$Anos_como_cliente = factor(data1$Anos_como_cliente,
                                 labels = c("Menos de 2", "De 2 a 5", "Mas de 5"))
data1$Meses_adeudo = as.factor(data1$Meses_adeudo)
data1$Numero_quejas = as.factor(data1$Numero_quejas)
data1$Debito_autom = as.factor(data1$Debito_autom)
data1$Recibio_oferta = as.factor(data1$Recibio_oferta)
data1$Tipo_Contrato = factor(data1$Tipo_Contrato)


# GRAFICANDO 
library(gcookbook) 
library(ggplot2)

#FILTRO DE VARIABLES
data1$Dado_de_baja = as.factor(data1$Dado_de_baja)
dat <- data1[c('Dado_de_baja', 'Sexo')]
View(dat)
str(dat)

# GRAFICAS 

dat2 <- dat[c('Dado_de_baja')]
pie(table(dat2))
porcentaje = sum(data1$Dado_de_baja == 1) / sum(data1$Dado_de_baja == 0)
# EN LA GRAFICA DE TORTA OBSERVAMOS LA PROPORCION DE LOS USUARIOS QUE SE DAN DE BAJA SOBRE LOS QUE PERMANECEN.
# EL PORCENTAJE DE LOS CLIENTES QUE SE DAN DE BAJA ES UN 11,35%.
      

# VARIABLES CATEGORICAS
# VARIABLE Sexo
ggplot(data1, aes(x = Sexo, fill=factor(Dado_de_baja))) + geom_bar(position= "stack")
ggplot(data1, aes(x = factor(Sexo), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
porcentaje_fuga_F = sum(data1$Sexo == "F" & data1$Dado_de_baja == 1)/ sum(data1$Sexo == "F")
porcentaje_fuga_M = sum(data1$Sexo == "M" & data1$Dado_de_baja == 1) / sum(data1$Sexo == "M")
# CONCLUSIONES: PODEMOS APRECIAR QUE EN EL TOTAL DE LA MUESTRA HAY MÁS MUJERES QUE HOMBRES.
# EN LA SEGUNDA GRÁFICA DE BARRAS, OBSERVAMOS QUE LAS MUJERES QUE SE DAN DE BAJA CORRESPONDEN A UN 9,45% 
# Y LOS HOMBRES QUE SE DAN DE BAJA CORRESPONDEN A UN 11,8%, POR LO TANTO SUPONEMOS QUE NO SERIA UNA VARIABLE MUY SIGNIFICTIVA.


# VARIABLE Tipo_Contrato
ggplot(data1, aes(x = factor(Tipo_Contrato), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: OBSERVAMOS QUE LA VARIABLE TIPO_CONTRATO SE DIVIDE EN: PREPAGO, BASICO, SUPERIOR Y PREMIUM.
# DETECTAMOS QUE LOS PLANES PREPAGO Y SUPERIOR POSEEN MAS USUARIOS QUE SE DAN DE BAJA. 
# A SU VES EL PLAN BASICO NO TIENE NINGUN CLIENTE QUE SE FUGUE.

# VARIABLE Meses_adeudo
ggplot(data1 , aes(x = factor(Meses_adeudo), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: A MEDIDA QUE AUMENTAN LOS MESES ADEUDO, AUMENTA LA PROBABILIDAD DE FUGA DE CLIENTES

# VARIABLE Numero_quejas
ggplot(data1 , aes(x = factor(Numero_quejas), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: A MEDIDA QUE AUMENTAN EL NUMERO DE QUEJAS, AUMENTA LA PROBABILIDAD DE FUGA DE CLIENTES


# VARIABLE Debito_autom
ggplot(data1 , aes(x = factor(Debito_autom), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: LOS CLIENTES QUE POSEEN DEBITO AUTOMATICO TIENEN MENOS PROBABILIDAD DE FUGA, AUNQUE PERCIBIMOS POCA 
# PREDICTIBILIDAD DE ESTA VARIABLE.

# VARIABLE Anos_como_cliente
ggplot(data1 , aes(x = factor(Anos_como_cliente), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: TANTO LOS CLIENTES MAS NUEVOS COMO LOS DE MÁS ANTIGUEDAD POSEEN MENOR PROBABILIDAD DE FUGA.
# LOS CLIENTES QUE POSEEN DE 2 A 5 AÑOS DE ANTIGUEDAD SON LOS MAS PROPENSOS A DARSE DE BAJA.

# VARIABLE Recibio_oferta
ggplot(data1 , aes(x = factor(Recibio_oferta), fill=factor(Dado_de_baja))) + geom_bar(position="fill")
# CONCLUSIONES: PERCIBIMOS QUE NO HAY CASI VARIABILIDAD ENTRE LOS QUE RECIBIERON Y LOS QUE NO RECIBIERON OFERTA.


# VARIABLES CONTINUAS
# VARIABLE INGRESO
outliers = boxplot(data1$Ingreso)$out
outliers
which(data1$Ingreso %in% outliers)
data1[which(data1$Ingreso %in% outliers),]
data2 <- data1[-which(data1$Ingreso %in% outliers),]
boxplot (data2$Ingreso ~ data2$Dado_de_baja, main = "Boxplot variable Ingreso")$out
# CONCLUSIONES: VEMOS QUE HAY UNA CORRELACION ENTRE EL INGRESO Y LA PROBABILIDAD DE FUGA,
# A MAYOR INGRESO, MENOS FUGA DE CLIENTES.

#VARIABLE VAR_CUOTA
boxplot (data1$Var_cuota_ult_ano ~ data1$Dado_de_baja, main = "Boxplot Variación de cuota")
# CONCLUSIONES: OBSERVAMOS QUE TANTO LOS CUARTILES COMO LA MEDIA ES SUPERIOR EN LOS CLIENTES
# QUE SE DAN DE BAJA, POR LO TANTO UNA VARIACION DE CUOTA POSITIVA ESTA DIRECTAMENTE RELACIONADO 
# CON LA FUGA DE CLIENTES. 

#VARIABLE EDAD
boxplot (data1$Edad ~ data1$Dado_de_baja, main = "Boxplot Edad")
# CONCLUSIONES: OBSERVAMOS QUE A MENOR EDAD, MAS PROBABILIDAD DE FUGA.



library(ISLR)
library(MASS)
library(randomForest)
library(rmarkdown)
library(class)
library(caret)
library(rpart)

##### PARTE 2 #####

#Estimación modelo por Cross-Validation K-fold con Boosting ( + Ganancia y Costo)

library(gbm)

data1$Dado_de_baja = ifelse(data1$Dado_de_baja == 0, 0, 1)

lambda = seq (0.01, 0.1, by= 0.02)
narb = seq(200, 1000 , by = 200)
deph = c(1:3)
resultados = data.frame()
k_folds = 5

folds = caret::createFolds(c(1:nrow(data1)),k=k_folds)
set.seed(1)
for (i in lambda ) {
  for (j in narb){
    for( h in deph){
      for (k in 1:k_folds){
        train= data1[folds[[k]],]
        test = data1[-folds[[k]],]
        y.test = data1[folds[[k]],"Dado_de_baja"]
        
        
      
        cv.boost.data = gbm(Dado_de_baja ~ ., data = train, distribution = "bernoulli", 
                          n.trees = j, interaction.depth = h, shrinkage = i,
                          verbose = FALSE)
        
        yhat_boost = predict (cv.boost.data, newdata = test, n.trees = j, type = "response")
        bc_data = data.frame(yhat_boost, y.test)
        bc_data_ord =bc_data[order(yhat_boost, decreasing = TRUE),] 
        bc_data_ord$cost = ifelse(bc_data_ord$y.test == 0, 30000, -500)
        bc_data_ord$ganacum = cumsum(bc_data_ord$cost)
        maxima_ganancia = max(bc_data_ord$ganacum)
        corte= bc_data_ord[which.max(bc_data_ord$ganacum),]$yhat_boost
        tab = table(ifelse(bc_data_ord$yhat_boost>corte,0,1),bc_data_ord$y.test) 
        acc= (tab[1,1]+tab[2,2])/sum(tab)
        resultados = rbind (resultados, data.frame (i, j, h , maxima_ganancia, corte, acc, k))
        
  }}}}

View(data1)
View(resultados)

# Gráfica de importancia de las variables
summary(cv.boost.data)


#Elección del mejor modelo y parámetros que optimicen 

library("dplyr")

?summarise
promedio_resultados_max_ganancia = resultados %>% group_by(i, j, h) %>% summarise(mean = mean(maxima_ganancia, na.rm = TRUE))
View(promedio_resultados_max_ganancia)

promedio_resultados_max_ganancia = promedio_resultados_max_ganancia[order(promedio_resultados_max_ganancia$mean, decreasing=TRUE),] 
head(promedio_resultados_max_ganancia,1)

cutoff = resultados%>% filter (i== 0.09, h==2, j==200)
promedio_cutoff = cutoff %>% summarise(mean = mean(corte, na.rm = TRUE))

boost.churn_mejor_modelo = gbm(Dado_de_baja ~ ., data = data1, distribution = "bernoulli", 
                               n.trees = 200, interaction.depth = 2, shrinkage = 0.09,
                               verbose = FALSE)

##### PARTE 4 #####

data2 = read.csv("db_test_churn_sinclase.csv", sep=";", header = T)
head(data2)
head(data1)
summary(data2)
str(data2)

data2$SEXO = as.factor(data2$SEXO)
data2$Tipo_Contrato = factor(data2$Tipo_Contrato,
                             labels = c("Prepago","Basico","Superior", "Premium"))
data2$Anos_como_cliente = factor(data2$Anos_como_cliente,
                                 labels = c("Menos de 2", "De 2 a 5", "Mas de 5"))
data2$Tipo_Contrato = as.factor(data2$Tipo_Contrato)
data2$Meses_adeudo = as.factor(data2$Meses_adeudo)
data2$Numero_quejas = as.factor(data2$Numero_quejas)
data2$Debito_autom = as.factor(data2$Debito_autom)
data2$Recibio_oferta = as.factor(data2$Recibio_oferta)

nombres_de_col <- names(data2)
nombres_de_col = c('Edad', 'Sexo', 'Ingreso', 'Tipo_Contrato', 'Meses_adeudo', 'Numero_quejas', 'Debito_autom', 'Var_cuota_ult_ano', 'Anos_como_cliente', 'Recibio_oferta')
names(data2) = nombres_de_col
head(data2)

prediccion_data2 <- predict(boost.churn_mejor_modelo,newdata=data2, n.trees=200, type="response")
View(prediccion_data2)
min(prediccion_data2)
prediccion_data2 <- ifelse(prediccion_data2>0.0026,0,1)
View(prediccion_data2)

write.csv(prediccion_data2,'D:/Users/Cecilia/Documents/POSGRADO - CIENCIA DE DATOS/7_MACHINE_LEARNING_I/Entrega_MLI.R') 



