############################################################
# CÓDIGO PARA REALIZACIÓN DE ANÁLISIS COSTE-BENEFICIO EN R #
############################################################
#                   ORGEMPLEG-210                          #
############################################################

# ---------------------- #
# VALOR ACTUALIZADO NETO #
# ---------------------- #

# VECTOR DATA : vector en el cual se incluyan los parámetros siguientes
# (fijar, dejar como parámetros variables según deseos)
# (se introducen como vector para el posterior análisis de sensibilidad)

# COSTES #
# ------ #
# Land costs
land.cost <- vector.data[1]
# Construction costs
cons.cost <- vector.data[2]
# General management costs
mgmt.cost <- vector.data[3]
# Operation costs
oper.cost <- vector.data[4]
# Human resources costs
humr.cost <- vector.data[5]
# Recovery costs
reco.cost <- vector.data[6]

# INGRESOS #
# -------- #
# Selling price
pric.inco <- vector.data[7]

# PRODUCCION #
# ---------- #
prod.data <- vector.data[8]

# PARÁMETROS BÁSICOS #
# ------------------ #
# Tasa de descuento
disc.rate <- vector.data[9]
# Horizonte temporal 
hozt.temp <- vector.data[10]


# SERIES TEMPORALES #
# ----------------- #
# Años
year.vector <- c(2019:(2019+3+hozt.temp+1))

# Land costs
land.cost.vector <- rep(0, length(year.vector))
land.cost.vector[1] <- land.cost

# Construction costs
cons.cost.vector <- rep(0, length(year.vector))
for (i in 1:3){
  cons.cost.vector[i] <- cons.cost/3
}

# General management costs
mgmt.cost.vector <- rep(0, length(year.vector))
for (i in 4:length(year.vector)){
  mgmt.cost.vector[i] <- mgmt.cost
}

# Operation costs
oper.cost.vector <- rep(0, length(year.vector))
for (i in 4:length(year.vector)){
  oper.cost.vector[i] <- oper.cost*prod.data
}

# Human resources costs
humr.cost.vector <- rep(0, length(year.vector))
for (i in 1:length(year.vector)){
  humr.cost.vector[i] <- humr.cost
}

# Recovery costs
reco.cost.vector <- rep(0, length(year.vector))
reco.cost.vector[length(year.vector)] <- reco.cost


# Incomes
inco.cost.vector <- rep(0, length(year.vector))
for (i in 4:(length(year.vector)-1)){
  inco.cost.vector[i] <- pric.inco*prod.data
}

# --------------------- # 
# BENEFITS / Beneficios #
# --------------------- #
ben.vector <- rep(0, length(year.vector))
netben.vector <- rep(0, length(year.vector))
for (i in (1):(length(year.vector))) {
  ben.vector[i] <- -land.cost.vector[i]-cons.cost.vector[i]-mgmt.cost.vector[i]-
    oper.cost.vector[i]-humr.cost.vector[i]-reco.cost.vector[i]+
    inco.cost.vector[i]
  netben.vector[i] <- ben.vector[i]/((1+disc.rate)^i)
}

# --------- # 
# NPV / VAN #
# --------- #
npv.result <- sum(netben.vector)
npv.result
