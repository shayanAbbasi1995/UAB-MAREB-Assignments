
# Dalia Argudo, november 2021
# Use of package IndexNumR to estimate productivity and prices indices Exercise 01
install.packages('Rcpp')
library('Rcpp')

install.packages("remotes")
remotes::install_github("grahamjwhite/IndexNumR")  

library(IndexNumR)  
library(openxlsx)   # package to import and export data to Excel


################

data_output<-read.xlsx("Exercise_index_numbers_01_assigment_prueba.xlsx", sheet="Outputs", colNames = TRUE)  # to read the file, first worksheet and using first row as a names of the data frame
data_input<-read.xlsx("Exercise_index_numbers_01_assigment_prueba.xlsx", sheet="Inputs", colNames = TRUE)  # to read the file, first worksheet and using first row as a names of the data frame

#######################################
# Period on Period Productivity Indices
#######################################

# 'period on period' OUTPUT indices
methods <- c("laspeyres","paasche","fisher","tornqvist")
out_index_pop <- lapply(methods, 
                     function(x) {quantityIndex(data_output,
                                                pvar = "prices", 
                                                qvar = "quantities", 
                                                pervar = "time", 
                                                prodID = "prodID", 
                                                indexMethod = x, 
                                                )})

out_index_pop<-as.data.frame(out_index_pop, col.names = methods)

# 'period on period' INPUT indices
methods <- c("laspeyres","paasche","fisher","tornqvist")
inp_index_pop <- lapply(methods, 
                        function(x) {quantityIndex(data_input,
                                                   pvar = "prices", 
                                                   qvar = "quantities", 
                                                   pervar = "time", 
                                                   prodID = "prodID", 
                                                   indexMethod = x, 
                        )})

inp_index_pop<-as.data.frame(inp_index_pop, col.names = methods)

#######################################################
# estimation of "period on period" productivity indices
#######################################################

Prod_index_pop = out_index_pop/inp_index_pop

write.xlsx(Prod_index_pop, file = "Sol_Prod_index_pop_assigment_prueba.xlsx", colNames = TRUE, rowNames = TRUE)

################################
# Period on Period Price Indices
################################

# 'period on period' OUTPUT indices
methods <- c("laspeyres","paasche","fisher","tornqvist")
out_index_pop <- lapply(methods, 
                        function(x) {priceIndex(data_output,
                                                   pvar = "prices", 
                                                   qvar = "quantities", 
                                                   pervar = "time", 
                                                   prodID = "prodID", 
                                                   indexMethod = x, 
                        )})

outprice_index_pop<-as.data.frame(out_index_pop, col.names = methods)

# 'period on period' INPUT indices
methods <- c("laspeyres","paasche","fisher","tornqvist")
inp_index_pop <- lapply(methods, 
                        function(x) {priceIndex(data_input,
                                                   pvar = "prices", 
                                                   qvar = "quantities", 
                                                   pervar = "time", 
                                                   prodID = "prodID", 
                                                   indexMethod = x, 
                        )})

inpprice_index_pop<-as.data.frame(inp_index_pop, col.names = methods)

############################################
# estimation of "period on period" productivity indices
############################################

Prices_index_pop = outprice_index_pop/inpprice_index_pop

write.xlsx(Prices_index_pop, file = "Sol_Prices_index_pop_assigment_prueba.xlsx", colNames = TRUE, rowNames = TRUE)



################################################
#  Calculating ACP
################################################
APC <- Prices_index_pop$paasche * Prod_index_pop$laspeyres


