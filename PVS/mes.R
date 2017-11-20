mes <- function(x) {
  dmy(paste("1", month(x), year(x)))
}

p<-ggplot(lll, aes(x=fch_a1, y=total)) + geom_line()
fff %>% group_by(fch_a1) %>% summarise(total=sum(a1))

select(hhh, matches("(^a\\d)|(^fch_)"), Sexo, edad, UAP, grupo, Identificador_de_Paciente)->sss


gather(sss, key, val, -c(Sexo, edad, UAP, grupo, Identificador_de_Paciente), -matches("^a\\d"))->ddd
