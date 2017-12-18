curva_pro <- function(z) {

   
varis<-with(z,list(fch_a1, fch_a1_af, fch_a1_dt, fch_a1_tb, fch_a2, fch_a2_af, fch_a2_dt, fch_a2_tb, fch_a4, fch_a4_af, fch_a4_dt, fch_a4_tb))
  
sacar_por<- function(y) {
y <- ifelse(is.na(y),as.Date("3999-01-01"), y)
sapply(fechas, function(x) {mean(y<=x)})
}
rr<-sapply(varis, sacar_por)
kk<-as.data.frame(cbind(fechas, rr))
colnames(kk)<-c("fechas", "A1","A1_AF", "A1_DT", "A1_TB", "A2","A2_AF", "A2_DT", "A2_TB", "A4","A4_AF", "A4_DT", "A4_TB")
kk$fechas <- fechas
return(kk)
}
